using OpenTelemetry;
using OpenTelemetry.Metrics;
using OpenTelemetry.Trace;

var builder = WebApplication.CreateBuilder(args);

// Configuración de OpenTelemetry
builder.Services.AddSingleton<TracerProvider>(_ =>
    Sdk.CreateTracerProviderBuilder()
        .AddAspNetCoreInstrumentation()
        .AddHttpClientInstrumentation()
        .AddOtlpExporter(options =>
        {
            options.Endpoint = new Uri("http://otel-collector:4317");
        })
        .Build());

builder.Services.AddSingleton<MeterProvider>(_ =>
    Sdk.CreateMeterProviderBuilder()
        .AddAspNetCoreInstrumentation()
        .AddRuntimeInstrumentation()
        .AddOtlpExporter(options =>
        {
            options.Endpoint = new Uri("http://otel-collector:4317");
        })
        .Build());

builder.Services.AddEndpointsApiExplorer();

var app = builder.Build();

app.UseHttpsRedirection();

// Endpoint GET de simulación
app.MapGet("/ping", () =>
{
    return Results.Ok(new { message = "pong", service = "ProductService", timestamp = DateTime.UtcNow });
})
.WithName("PingService");

app.Run();
