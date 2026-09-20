# Lista de servicios con sus puertos
$services = @{
    users = 5001
    products = 5002
    orders = 5003
    payments = 5004
    inventory = 5005
    shipping = 5006
    cart = 5007
    reviews = 5008
    auth = 5009
    notifications = 5010
    analytics = 5011
    support = 5012
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
