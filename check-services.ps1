# Lista de servicios con sus puertos
$services = @{
    users = 5091
    products = 5257
    orders = 5059
    payments = 5195
    inventory = 5138
    shipping = 5134
    cart = 5151
    reviews = 5146
    auth = 5292
    notifications = 5221
    analytics = 5126
    support = 5185
}

Write-Host "🔎 Validando microservicios..."

foreach ($service in $services.Keys) {
    $port = $services[$service]
    $url = "http://localhost:$port/metrics"

    try {
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 3
        if ($response.Content -match "# HELP") {
            Write-Host "➡️ $service ($url): ✅ responde métricas"
        } else {
            Write-Host "➡️ $service ($url): ⚠️ responde pero no contiene métricas"
        }
    }
    catch {
        Write-Host "➡️ $service ($url): ❌ no responde"
    }
}
