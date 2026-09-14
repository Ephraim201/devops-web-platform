import os

from flask import Flask

from opentelemetry import trace
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter
from opentelemetry.instrumentation.flask import FlaskInstrumentor
from opentelemetry.sdk.resources import Resource
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import BatchSpanProcessor


app = Flask(__name__)

message = os.getenv(
    "APP_MESSAGE",
    "DevOps Web Platform funcionando correctamente"
)


resource = Resource.create(
    {
        "service.name": os.getenv(
            "OTEL_SERVICE_NAME",
            "devops-web-platform"
        )
    }
)

trace_provider = TracerProvider(resource=resource)

otlp_exporter = OTLPSpanExporter(
    endpoint=os.getenv(
        "OTEL_EXPORTER_OTLP_TRACES_ENDPOINT",
        "http://opentelemetry-collector.observability.svc.cluster.local:4318/v1/traces"
    )
)

trace_provider.add_span_processor(
    BatchSpanProcessor(otlp_exporter)
)

trace.set_tracer_provider(trace_provider)

FlaskInstrumentor().instrument_app(app)


@app.route("/")
def home():
    return message


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)