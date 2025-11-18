# Script para clonar todos los repositorios necesarios
# Ejecutar en PowerShell

Write-Host "🚀 Clonando repositorios de Estación Café..." -ForegroundColor Cyan

# Frontend
if (-Not (Test-Path "EstacionCafeFrontend")) {
    Write-Host "📦 Clonando Frontend..." -ForegroundColor Yellow
    git clone https://github.com/ChrisCarcamo1605/EstacionCafeFrontend.git
} else {
    Write-Host "✅ Frontend ya existe" -ForegroundColor Green
}

# Backend (actualizar con tu URL real)
if (-Not (Test-Path "EstacionCafe-Backend")) {
    Write-Host "📦 Clonando Backend..." -ForegroundColor Yellow
    Write-Host "⚠️  Actualiza la URL del backend en este script" -ForegroundColor Red
    # git clone <URL-DE-TU-REPO-BACKEND> EstacionCafe-Backend
} else {
    Write-Host "✅ Backend ya existe" -ForegroundColor Green
}

# ML Dashboard (actualizar con tu URL real)
if (-Not (Test-Path "EstacionCafe-ML")) {
    Write-Host "📦 Clonando ML Dashboard..." -ForegroundColor Yellow
    Write-Host "⚠️  Actualiza la URL del ML en este script" -ForegroundColor Red
    # git clone <URL-DE-TU-REPO-ML> EstacionCafe-ML
} else {
    Write-Host "✅ ML Dashboard ya existe" -ForegroundColor Green
}

Write-Host ""
Write-Host "✨ Repositorios listos!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Próximos pasos:" -ForegroundColor Cyan
Write-Host "1. Actualiza las URLs de los repos en este script (setup.ps1)"
Write-Host "2. Ejecuta: docker-compose up -d"
Write-Host "3. Accede a: http://localhost:4321"
