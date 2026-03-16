/*
 * Zuzu Hernández - Portafolio de Fotografía de Modas
 * Proyecto ASP.NET Core
 * Configuración para servir archivos estáticos
 */

using Microsoft.Extensions.FileProviders;

var builder = WebApplication.CreateBuilder(args);
var app = builder.Build();

// Habilitar archivos estáticos de wwwroot
app.UseStaticFiles();

// Habilitar archivos estáticos desde la raíz del proyecto (fotosDeWeb)
app.UseStaticFiles(new StaticFileOptions
{
    FileProvider = new PhysicalFileProvider(
        Path.Combine(Directory.GetCurrentDirectory())),
    RequestPath = ""
});

// Configurar página principal
app.MapGet("/", async context =>
{
    context.Response.Redirect("/prototipo.html");
});

app.Run();