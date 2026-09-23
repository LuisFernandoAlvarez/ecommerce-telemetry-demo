# Lista de microservicios y namespace
$services = @(
    "analytics-service",
    "users-service",
    "products-service",
    "orders-service",
    "cart-service",
    "auth-service",
    "payments-service",
    "shipping-service",
    "reviews-service",
    "inventory-service",
    "notifications-service",
    "support-service"
)

$namespace = "default"
$port = 8080
$path = "/metrics"

Write-Host "🔎 Validando endpoints de métricas en namespace '$namespace'..."

foreach ($svc in $services) {
    try {
        $url = "http://$svc.$namespace.svc.cluster.local:$port$path"
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5

        if ($response.StatusCode -eq 200) {
            Write-Host ("✅ {0} responde en {1}" -f $svc, $url)
        } else {
            Write-Host ("⚠️ {0} respondió con código {1}" -f $svc, $response.StatusCode)
        }
    }
    catch {
        Write-Host ("❌ Error al conectar con {0}: {1}" -f $svc, $_.Exception.Message)
    }
}
