$service = "devops-web-platform"
$greenDeployment = "devops-web-platform-green"

$greenPatchFile = ".\scripts\green-patch.json"
$bluePatchFile = ".\scripts\blue-patch.json"

Write-Host "========================================="
Write-Host " BLUE-GREEN - ROLLBACK AUTOMATICO"
Write-Host "========================================="

Write-Host ""
Write-Host "[1] Comprobando Green..."

kubectl get deployment $greenDeployment

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Green no existe."
    Write-Host "ROLLBACK AUTOMATICO -> BLUE"

    kubectl patch service $service --type=merge --patch-file $bluePatchFile

    exit 1
}

Write-Host ""
Write-Host "[2] Esperando rollout de Green..."

kubectl rollout status deployment/$greenDeployment --timeout=120s

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Green no supera el rollout."
    Write-Host "ROLLBACK AUTOMATICO -> BLUE"

    kubectl patch service $service --type=merge --patch-file $bluePatchFile

    exit 1
}

Write-Host ""
Write-Host "[3] Buscando pods Green..."

$greenPod = kubectl get pods -l app=devops-web-platform,version=green -o jsonpath="{.items[0].metadata.name}"

if ([string]::IsNullOrWhiteSpace($greenPod)) {
    Write-Host "ERROR: No hay pods Green."
    Write-Host "ROLLBACK AUTOMATICO -> BLUE"

    kubectl patch service $service --type=merge --patch-file $bluePatchFile

    exit 1
}

Write-Host "Pod Green: $greenPod"

Write-Host ""
Write-Host "[4] Health check de Green..."

kubectl exec $greenPod -- python -c "import urllib.request; r=urllib.request.urlopen('http://127.0.0.1:5000/', timeout=5); print('HTTP', r.status)"

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: Health check de Green FALLIDO."
    Write-Host "ROLLBACK AUTOMATICO -> BLUE"

    kubectl patch service $service --type=merge --patch-file $bluePatchFile

    exit 1
}

Write-Host "Health check OK."

Write-Host ""
Write-Host "[5] Cambiando trafico -> GREEN..."

kubectl patch service $service --type=merge --patch-file $greenPatchFile

if ($LASTEXITCODE -ne 0) {
    Write-Host "ERROR: No se pudo activar Green."
    Write-Host "ROLLBACK AUTOMATICO -> BLUE"

    kubectl patch service $service --type=merge --patch-file $bluePatchFile

    exit 1
}

Write-Host ""
Write-Host "========================================="
Write-Host " GREEN ACTIVADO CORRECTAMENTE"
Write-Host "========================================="

Write-Host ""
Write-Host "Selector actual del Service:"
kubectl get service $service -o jsonpath="{.spec.selector.version}"

Write-Host ""
Write-Host ""
Write-Host "Endpoints actuales:"
kubectl get endpoints $service
