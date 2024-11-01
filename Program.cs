using Microsoft.EntityFrameworkCore;
using thesis_exercise.Data;
using thesis_exercise.Repositories;
using thesis_exercise.Models;


var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddControllersWithViews();

builder.Services.AddControllers()
    .AddNewtonsoftJson(options =>
    {
        options.SerializerSettings.ReferenceLoopHandling = Newtonsoft.Json.ReferenceLoopHandling.Ignore;
    });

//Register DbContext
builder.Services.AddDbContext<CatalogContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("db")));

//Register |repository
builder.Services.AddScoped<IComputerRepository, ComputerRepository>();

// Add CORS service
//builder.Services.AddCors(options =>
//{
//    options.AddPolicy("CorsPolicy", builder =>
//    {
//        builder.WithOrigins("https://127.0.0.1:44449/", "https://localhost:44395/", "https://localhost:38590/") // Replace with your origin
//               .AllowAnyMethod()
//               .AllowCredentials()
//               .AllowAnyHeader();
//    });
//});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
app.UseRouting();

// Use CORS middleware
//app.UseCors("CorsPolicy");

//app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller}/{action=Index}/{id?}");

app.MapFallbackToFile("index.html");

app.Run();
