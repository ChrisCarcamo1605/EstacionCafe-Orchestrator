# Script de inicialización para Estación Café
# Ejecutar en PowerShell: .\setup.ps1

param(
    [switch]$SkipDependencies,
    [switch]$Force
)

# Colores para output
$ErrorColor = "Red"
$SuccessColor = "Green"
$InfoColor = "Cyan"
$WarningColor = "Yellow"

# Banner
Write-Host ""
Write-Host "☕ ===============================================" -ForegroundColor $InfoColor
Write-Host "   ESTACIÓN CAFÉ - SCRIPT DE INICIALIZACIÓN" -ForegroundColor $InfoColor
Write-Host "   =============================================" -ForegroundColor $InfoColor
Write-Host ""

# Verificar requisitos
Write-Host "🔍 Verificando requisitos previos..." -ForegroundColor $InfoColor

# Verificar Git
try {
    $gitVersion = git --version
    Write-Host "  ✅ Git instalado: $gitVersion" -ForegroundColor $SuccessColor
} catch {
    Write-Host "  ❌ Git no está instalado. Por favor instala Git desde https://git-scm.com/" -ForegroundColor $ErrorColor
    exit 1
}

# Verificar Docker
try {
    $dockerVersion = docker --version
    Write-Host "  ✅ Docker instalado: $dockerVersion" -ForegroundColor $SuccessColor
} catch {
    Write-Host "  ⚠️  Docker no está instalado. Lo necesitarás para ejecutar los servicios." -ForegroundColor $WarningColor
}

# Verificar Node.js
try {
    $nodeVersion = node --version
    Write-Host "  ✅ Node.js instalado: $nodeVersion" -ForegroundColor $SuccessColor
} catch {
    Write-Host "  ⚠️  Node.js no está instalado. Lo necesitarás para desarrollo local." -ForegroundColor $WarningColor
}

Write-Host ""
Write-Host "📥 Clonando repositorios..." -ForegroundColor $InfoColor
Write-Host ""

# Frontend
if (Test-Path "EstacionCafeFrontend") {
    if ($Force) {
        Write-Host "  🔄 Frontend existe, eliminando para clonar de nuevo..." -ForegroundColor $WarningColor
        Remove-Item -Recurse -Force "EstacionCafeFrontend"
        Write-Host "  📦 Clonando Frontend..." -ForegroundColor $InfoColor
        git clone https://github.com/ChrisCarcamo1605/EstacionCafeFrontend.git
    } else {
        Write-Host "  ✅ Frontend ya existe (usa -Force para reclonar)" -ForegroundColor $SuccessColor
    }
} else {
    Write-Host "  📦 Clonando Frontend..." -ForegroundColor $InfoColor
    git clone https://github.com/ChrisCarcamo1605/EstacionCafeFrontend.git
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ Frontend clonado exitosamente" -ForegroundColor $SuccessColor
    } else {
        Write-Host "  ❌ Error al clonar Frontend" -ForegroundColor $ErrorColor
    }
}

# Backend
if (Test-Path "EstacionCafe-Backend") {
    if ($Force) {
        Write-Host "  🔄 Backend existe, eliminando para clonar de nuevo..." -ForegroundColor $WarningColor
        Remove-Item -Recurse -Force "EstacionCafe-Backend"
        Write-Host "  📦 Clonando Backend..." -ForegroundColor $InfoColor
        git clone https://github.com/ChrisCarcamo1605/EstacionCafe-Backend.git EstacionCafe-Backend
    } else {
        Write-Host "  ✅ Backend ya existe (usa -Force para reclonar)" -ForegroundColor $SuccessColor
    }
} else {
    Write-Host "  📦 Clonando Backend..." -ForegroundColor $InfoColor
    git clone https://github.com/ChrisCarcamo1605/EstacionCafe-Backend.git EstacionCafe-Backend
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ Backend clonado exitosamente" -ForegroundColor $SuccessColor
    } else {
        Write-Host "  ❌ Error al clonar Backend" -ForegroundColor $ErrorColor
    }
}

# ML Dashboard
if (Test-Path "machinelearningcafeteria") {
    if ($Force) {
        Write-Host "  🔄 ML Dashboard existe, eliminando para clonar de nuevo..." -ForegroundColor $WarningColor
        Remove-Item -Recurse -Force "machinelearningcafeteria"
        Write-Host "  📦 Clonando ML Dashboard..." -ForegroundColor $InfoColor
        git clone https://github.com/Chrislight879/machinelearningcafeteria.git machinelearningcafeteria
    } else {
        Write-Host "  ✅ ML Dashboard ya existe (usa -Force para reclonar)" -ForegroundColor $SuccessColor
    }
} else {
    Write-Host "  📦 Clonando ML Dashboard..." -ForegroundColor $InfoColor
    git clone https://github.com/Chrislight879/machinelearningcafeteria.git machinelearningcafeteria
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✅ ML Dashboard clonado exitosamente" -ForegroundColor $SuccessColor
    } else {
        Write-Host "  ❌ Error al clonar ML Dashboard" -ForegroundColor $ErrorColor
    }
}

# Instalar dependencias
if (-Not $SkipDependencies) {
    Write-Host ""
    Write-Host "📦 Instalando dependencias..." -ForegroundColor $InfoColor
    Write-Host ""
    
    # Frontend dependencies
    if (Test-Path "EstacionCafeFrontend\package.json") {
        Write-Host "  📦 Instalando dependencias del Frontend..." -ForegroundColor $InfoColor
        Push-Location EstacionCafeFrontend
        npm install
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✅ Dependencias del Frontend instaladas" -ForegroundColor $SuccessColor
        } else {
            Write-Host "  ⚠️  Error al instalar dependencias del Frontend" -ForegroundColor $WarningColor
        }
        Pop-Location
        
        # Email service dependencies
        if (Test-Path "EstacionCafeFrontend\server\package.json") {
            Write-Host "  📦 Instalando dependencias del Email Service..." -ForegroundColor $InfoColor
            Push-Location EstacionCafeFrontend\server
            npm install
            if ($LASTEXITCODE -eq 0) {
                Write-Host "  ✅ Dependencias del Email Service instaladas" -ForegroundColor $SuccessColor
            } else {
                Write-Host "  ⚠️  Error al instalar dependencias del Email Service" -ForegroundColor $WarningColor
            }
            Pop-Location
        }
    }
    
    # Backend dependencies
    if (Test-Path "EstacionCafe-Backend\package.json") {
        Write-Host "  📦 Instalando dependencias del Backend..." -ForegroundColor $InfoColor
        Push-Location EstacionCafe-Backend
        npm install
        if ($LASTEXITCODE -eq 0) {
            Write-Host "  ✅ Dependencias del Backend instaladas" -ForegroundColor $SuccessColor
        } else {
            Write-Host "  ⚠️  Error al instalar dependencias del Backend" -ForegroundColor $WarningColor
        }
        Pop-Location
    }
    
    # ML Dashboard dependencies
    if (Test-Path "machinelearningcafeteria\requirements.txt") {
        Write-Host "  📦 Instalando dependencias del ML Dashboard..." -ForegroundColor $InfoColor
        try {
            $pythonCmd = Get-Command python -ErrorAction SilentlyContinue
            if (-Not $pythonCmd) {
                $pythonCmd = Get-Command python3 -ErrorAction SilentlyContinue
            }
            
            if ($pythonCmd) {
                Push-Location machinelearningcafeteria
                & $pythonCmd.Source -m pip install -r requirements.txt
                if ($LASTEXITCODE -eq 0) {
                    Write-Host "  ✅ Dependencias del ML Dashboard instaladas" -ForegroundColor $SuccessColor
                } else {
                    Write-Host "  ⚠️  Error al instalar dependencias del ML Dashboard" -ForegroundColor $WarningColor
                }
                Pop-Location
            } else {
                Write-Host "  ⚠️  Python no está instalado. Saltando dependencias de ML" -ForegroundColor $WarningColor
            }
        } catch {
            Write-Host "  ⚠️  Error al instalar dependencias de Python: $_" -ForegroundColor $WarningColor
        }
    }
} else {
    Write-Host ""
    Write-Host "⏭️  Saltando instalación de dependencias (-SkipDependencies)" -ForegroundColor $WarningColor
}

Write-Host ""
Write-Host "✨ =============================================" -ForegroundColor $SuccessColor
Write-Host "   INICIALIZACIÓN COMPLETADA" -ForegroundColor $SuccessColor
Write-Host "   =============================================" -ForegroundColor $SuccessColor
Write-Host ""
Write-Host "📝 Próximos pasos:" -ForegroundColor $InfoColor
Write-Host ""
Write-Host "  1️⃣  Configurar variables de entorno:" -ForegroundColor $InfoColor
Write-Host "     - EstacionCafe-Backend\DB_CREDENTIALS.env" -ForegroundColor $InfoColor
Write-Host "     - EstacionCafe-Backend\SECURITY_CREDENTIALS.env" -ForegroundColor $InfoColor
Write-Host ""
Write-Host "  2️⃣  Levantar servicios con Docker:" -ForegroundColor $InfoColor
Write-Host "     docker-compose up -d" -ForegroundColor $WarningColor
Write-Host ""
Write-Host "  3️⃣  Acceder a los servicios:" -ForegroundColor $InfoColor
Write-Host "     Frontend:     http://localhost:4321" -ForegroundColor $InfoColor
Write-Host "     Backend API:  http://localhost:3484" -ForegroundColor $InfoColor
Write-Host "     ML Dashboard: http://localhost:8000" -ForegroundColor $InfoColor
Write-Host "     Email:        http://localhost:3004" -ForegroundColor $InfoColor
Write-Host ""
Write-Host "💡 Comandos útiles:" -ForegroundColor $InfoColor
Write-Host "   Ver logs:           docker-compose logs -f" -ForegroundColor $InfoColor
Write-Host "   Ver estado:         docker-compose ps" -ForegroundColor $InfoColor
Write-Host "   Detener servicios:  docker-compose down" -ForegroundColor $InfoColor
Write-Host ""
Write-Host "📖 Para más información, consulta el README.md" -ForegroundColor $InfoColor
Write-Host ""
