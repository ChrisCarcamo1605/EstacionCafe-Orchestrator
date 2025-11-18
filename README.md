# ☕ Estación Café - Orquestador Docker

Repositorio orquestador para levantar todos los servicios de Estación Café en contenedores Docker.

## 📦 Repositorios de Servicios

Este proyecto orquesta los siguientes repositorios:

- **Frontend**: https://github.com/ChrisCarcamo1605/EstacionCafeFrontend
- **Backend**: https://github.com/ChrisCarcamo1605/EstacionCafe (configurar)
- **ML Dashboard**: https://github.com/ChrisCarcamo1605/EstacionCafe-ML (configurar)
- **Email Service**: Incluido en el frontend

## 🚀 Inicio Rápido

### Instalación Automática (Recomendado) ⚡

```bash
# 1. Clonar este orquestador
git clone <url-de-este-repo>
cd EstacionCafe-Orchestrator

# 2. Instalar dependencias del orquestador
npm install

# 3. Ejecutar setup (clona repos + instala dependencias)
npm run setup
```

**Opciones disponibles:**
```bash
npm run setup              # Configuración completa
npm run setup:force        # Reclonar todo desde cero
npm run setup:skip-deps    # Solo clonar, sin instalar dependencias
```

**El setup automáticamente:**
- ✅ Verifica requisitos (Git, Docker, Node.js, Python)
- ✅ Clona los 3 repositorios necesarios
- ✅ Instala dependencias de Frontend (npm install)
- ✅ Instala dependencias de Backend (npm install)
- ✅ Instala dependencias de Email Service (npm install)
- ✅ Instala dependencias de ML Dashboard (pip install)

### Levantar los Servicios 🐳

```bash
# Desarrollo (con logs en consola)
npm run dev:all

# Desarrollo con rebuild
npm run dev:build

# Producción (en background)
npm start

# Producción con rebuild
npm run start:build
```

## 🌐 URLs de Servicios

Una vez levantados, accede a:

- **Frontend**: http://localhost:4321
- **Backend API**: http://localhost:3484
- **ML Dashboard**: http://localhost:8000
- **Email Service**: http://localhost:3004
- **PostgreSQL**: localhost:5555

## 📂 Estructura de Carpetas

Después de ejecutar `setup.ps1`, tendrás esta estructura:

```
EstacionCafe-Orchestrator/
├── EstacionCafeFrontend/        # Repo del frontend
│   ├── src/
│   ├── public/
│   ├── server/                  # Email service
│   └── package.json
├── EstacionCafe-Backend/        # Repo del backend
│   ├── application/
│   ├── controller/
│   ├── core/
│   ├── infrastructure/
│   └── package.json
├── machinelearningcafeteria/    # Repo del ML Dashboard
│   ├── app/
│   ├── main.py
│   └── requirements.txt
├── docker-compose.yml           # Orquestador maestro
├── setup.ps1                    # Script de inicialización
└── README.md                    # Este archivo
```

## 🛠️ Comandos Útiles

### Gestión de Servicios
```bash
npm start                  # Iniciar todos los servicios
npm run start:build        # Iniciar con rebuild
npm stop                   # Detener servicios
npm restart                # Reiniciar servicios
npm run status             # Ver estado de servicios
```

### Logs y Debug
```bash
npm run logs               # Ver logs de todos
npm run logs:frontend      # Logs del frontend
npm run logs:backend       # Logs del backend
npm run logs:ml            # Logs del ML Dashboard
npm run logs:email         # Logs del email service
```

### Desarrollo
```bash
npm run dev:all            # Modo desarrollo (con logs)
npm run dev:build          # Modo desarrollo con rebuild
```

### Limpieza
```bash
npm run stop:clean         # Detener y limpiar volúmenes
npm run clean              # Limpieza completa de Docker
```

### Comandos Docker Directos (alternativa)
```bash
docker-compose up -d       # Iniciar
docker-compose down        # Detener
docker-compose logs -f     # Ver logs
docker-compose ps          # Ver estado
```

## 🔧 Desarrollo Individual

Cada servicio puede desarrollarse independientemente sin Docker:

### Frontend
```bash
cd EstacionCafeFrontend
npm install          # Solo si no corriste npm run setup
npm run dev
```

### Backend
```bash
cd EstacionCafe-Backend
npm install          # Solo si no corriste npm run setup
npm start
```

### ML Dashboard
```bash
cd machinelearningcafeteria
pip install -r requirements.txt  # Solo si no corriste npm run setup
python main.py
```

## 🐛 Solución de Problemas

**Los contenedores no se pueden comunicar:**
- Verifica que todos estén en la misma red Docker
- Usa nombres de servicios en las URLs (ej: `http://backend:3484`)

**Puerto en uso:**
```bash
# Windows
netstat -ano | findstr :4321
taskkill /PID <PID> /F
```

**Reconstruir desde cero:**
```bash
docker-compose down -v
docker-compose up -d --build
```

## 📋 Requisitos Previos

Antes de ejecutar el script de inicialización, asegúrate de tener instalado:

- ✅ **Git** (obligatorio) - [Descargar](https://git-scm.com/)
- ✅ **Docker Desktop** (para contenedores) - [Descargar](https://www.docker.com/products/docker-desktop)
- ✅ **Node.js** v18+ (para desarrollo local) - [Descargar](https://nodejs.org/)
- ✅ **Python** 3.8+ (para ML Dashboard) - [Descargar](https://www.python.org/)
- 🔐 Acceso a los repositorios (si son privados)

El script `setup.ps1` verificará automáticamente estos requisitos al ejecutarse.

## 🔐 Configuración de Variables de Entorno

Cada servicio maneja sus propias variables de entorno:

- Frontend: `.env.docker` en EstacionCafeFrontend
- Backend: `DB_CREDENTIALS.env` y `SECURITY_CREDENTIALS.env` en EstacionCafe-Backend
- Email: `.env.docker` en EstacionCafeFrontend/server

## 👨‍💻 Contribuir

Para contribuir a un servicio específico, ve al repositorio correspondiente.

---

**Desarrollado por:** ChrisCarcamo1605  
**Año:** 2025
