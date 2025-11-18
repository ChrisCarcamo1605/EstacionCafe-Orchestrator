# ☕ Estación Café - Orquestador Docker

Repositorio orquestador para levantar todos los servicios de Estación Café en contenedores Docker.

## 📦 Repositorios de Servicios

Este proyecto orquesta los siguientes repositorios:

- **Frontend**: https://github.com/ChrisCarcamo1605/EstacionCafeFrontend
- **Backend**: https://github.com/ChrisCarcamo1605/EstacionCafe (configurar)
- **ML Dashboard**: https://github.com/ChrisCarcamo1605/EstacionCafe-ML (configurar)
- **Email Service**: Incluido en el frontend

## 🚀 Inicio Rápido

### 1. Clonar todos los repositorios

```bash
# Clonar este orquestador
git clone <url-de-este-repo>
cd EstacionCafe-Orchestrator

# Clonar los servicios
git clone https://github.com/ChrisCarcamo1605/EstacionCafeFrontend
git clone <url-backend> EstacionCafe-Backend
git clone <url-ml> machinelearningcafeteria
```

### 2. Levantar todos los servicios

```bash
docker-compose up -d
```

### 3. Verificar que todo está corriendo

```bash
docker-compose ps
```

## 🌐 URLs de Servicios

Una vez levantados, accede a:

- **Frontend**: http://localhost:4321
- **Backend API**: http://localhost:3484
- **ML Dashboard**: http://localhost:8000
- **Email Service**: http://localhost:3004
- **PostgreSQL**: localhost:5555

## 📂 Estructura de Carpetas Esperada

```
EstacionCafe-Orchestrator/
├── EstacionCafeFrontend/        # Repo del frontend
├── EstacionCafe-Backend/        # Repo del backend
├── EstacionCafe-ML/             # Repo del ML
├── docker-compose.yml           # Orquestador maestro
└── README.md                    # Este archivo
```

## 🛠️ Comandos Útiles

```bash
# Levantar todos los servicios
docker-compose up -d

# Ver logs de todos los servicios
docker-compose logs -f

# Ver logs de un servicio específico
docker-compose logs -f frontend
docker-compose logs -f backend
docker-compose logs -f ml-dashboard

# Detener todos los servicios
docker-compose down

# Reconstruir y levantar
docker-compose up -d --build

# Ver estado de servicios
docker-compose ps
```

## 🔧 Desarrollo Individual

Cada servicio puede desarrollarse independientemente:

### Frontend
```bash
cd EstacionCafeFrontend
npm install
npm run dev
```

### Backend
```bash
cd EstacionCafe-Backend
npm install
npm start
```

### ML Dashboard
```bash
cd EstacionCafe-ML
pip install -r requirements.txt
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

## 📋 Requisitos

- Docker Desktop instalado
- Git instalado
- Acceso a los repositorios privados (si aplica)

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
