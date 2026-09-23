# Lista de servicios con sus puertos
$services = @{
    "users" = 8080
}

Write-Host "🚀 Generando tráfico de prueba en 12 microservicios..."

foreach ($service in $services.Keys) {
    $port = $services[$service]
    Write-Host "➡️ $service (http://localhost:$port/ping)"

    for ($i=1; $i -le 1000; $i++) {
        try {
            $response = Invoke-WebRequest -Uri "http://localhost:$port/ping" -UseBasicParsing -TimeoutSec 2
            Write-Host "$i - $($response.StatusCode)"
        } catch {
            Write-Host "$i - ERROR: $($_.Exception.Message)"
        }
    }
}

Write-Host "✅ Tráfico generado. Revisa Prometheus y Grafana."
