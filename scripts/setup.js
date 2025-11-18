#!/usr/bin/env node

const { execSync, spawn } = require('child_process');
const fs = require('fs');
const path = require('path');

// Colores para consola
const colors = {
  reset: '\x1b[0m',
  bright: '\x1b[1m',
  red: '\x1b[31m',
  green: '\x1b[32m',
  yellow: '\x1b[33m',
  cyan: '\x1b[36m',
};

// Parsear argumentos
const args = process.argv.slice(2);
const force = args.includes('--force');
const skipDeps = args.includes('--skip-deps');

// Función para ejecutar comandos
function execCommand(command, options = {}) {
  try {
    execSync(command, { stdio: 'inherit', ...options });
    return true;
  } catch (error) {
    return false;
  }
}

// Función para verificar si un comando existe
function commandExists(command) {
  try {
    execSync(`${command} --version`, { stdio: 'ignore' });
    return true;
  } catch {
    return false;
  }
}

// Función para log con color
function log(message, color = 'reset') {
  console.log(`${colors[color]}${message}${colors.reset}`);
}

// Banner
console.log('');
log('☕ ===============================================', 'cyan');
log('   ESTACIÓN CAFÉ - SCRIPT DE INICIALIZACIÓN', 'cyan');
log('   ===============================================', 'cyan');
console.log('');

// Verificar requisitos
log('🔍 Verificando requisitos previos...', 'cyan');

if (!commandExists('git')) {
  log('  ❌ Git no está instalado. Instálalo desde https://git-scm.com/', 'red');
  process.exit(1);
}
log('  ✅ Git instalado', 'green');

if (!commandExists('docker')) {
  log('  ⚠️  Docker no está instalado. Lo necesitarás para ejecutar los servicios.', 'yellow');
} else {
  log('  ✅ Docker instalado', 'green');
}

if (!commandExists('node')) {
  log('  ❌ Node.js no está instalado. Este script requiere Node.js.', 'red');
  process.exit(1);
}
log('  ✅ Node.js instalado', 'green');

console.log('');
log('📥 Clonando repositorios...', 'cyan');
console.log('');

// Repositorios a clonar
const repos = [
  {
    name: 'Frontend',
    url: 'https://github.com/ChrisCarcamo1605/EstacionCafeFrontend.git',
    dir: 'EstacionCafeFrontend',
  },
  {
    name: 'Backend',
    url: 'https://github.com/ChrisCarcamo1605/EstacionCafe-Backend.git',
    dir: 'EstacionCafe-Backend',
  },
  {
    name: 'ML Dashboard',
    url: 'https://github.com/Chrislight879/machinelearningcafeteria.git',
    dir: 'machinelearningcafeteria',
  },
];

// Clonar repositorios
repos.forEach(({ name, url, dir }) => {
  if (fs.existsSync(dir)) {
    if (force) {
      log(`  🔄 ${name} existe, eliminando para reclonar...`, 'yellow');
      fs.rmSync(dir, { recursive: true, force: true });
      log(`  📦 Clonando ${name}...`, 'cyan');
      if (execCommand(`git clone ${url} ${dir}`)) {
        log(`  ✅ ${name} clonado exitosamente`, 'green');
      } else {
        log(`  ❌ Error al clonar ${name}`, 'red');
      }
    } else {
      log(`  ✅ ${name} ya existe (usa --force para reclonar)`, 'green');
    }
  } else {
    log(`  📦 Clonando ${name}...`, 'cyan');
    if (execCommand(`git clone ${url} ${dir}`)) {
      log(`  ✅ ${name} clonado exitosamente`, 'green');
    } else {
      log(`  ❌ Error al clonar ${name}`, 'red');
    }
  }
});

// Instalar dependencias
if (!skipDeps) {
  console.log('');
  log('📦 Instalando dependencias...', 'cyan');
  console.log('');

  // Frontend
  if (fs.existsSync('EstacionCafeFrontend/package.json')) {
    log('  📦 Instalando dependencias del Frontend...', 'cyan');
    if (execCommand('npm install', { cwd: 'EstacionCafeFrontend' })) {
      log('  ✅ Dependencias del Frontend instaladas', 'green');
    } else {
      log('  ⚠️  Error al instalar dependencias del Frontend', 'yellow');
    }

    // Email service
    if (fs.existsSync('EstacionCafeFrontend/server/package.json')) {
      log('  📦 Instalando dependencias del Email Service...', 'cyan');
      if (execCommand('npm install', { cwd: 'EstacionCafeFrontend/server' })) {
        log('  ✅ Dependencias del Email Service instaladas', 'green');
      } else {
        log('  ⚠️  Error al instalar dependencias del Email Service', 'yellow');
      }
    }
  }

  // Backend
  if (fs.existsSync('EstacionCafe-Backend/package.json')) {
    log('  📦 Instalando dependencias del Backend...', 'cyan');
    if (execCommand('npm install', { cwd: 'EstacionCafe-Backend' })) {
      log('  ✅ Dependencias del Backend instaladas', 'green');
    } else {
      log('  ⚠️  Error al instalar dependencias del Backend', 'yellow');
    }
  }

  // ML Dashboard
  if (fs.existsSync('machinelearningcafeteria/requirements.txt')) {
    log('  📦 Instalando dependencias del ML Dashboard...', 'cyan');
    const pythonCmd = commandExists('python') ? 'python' : commandExists('python3') ? 'python3' : null;
    
    if (pythonCmd) {
      if (execCommand(`${pythonCmd} -m pip install -r requirements.txt`, { cwd: 'machinelearningcafeteria' })) {
        log('  ✅ Dependencias del ML Dashboard instaladas', 'green');
      } else {
        log('  ⚠️  Error al instalar dependencias del ML Dashboard', 'yellow');
      }
    } else {
      log('  ⚠️  Python no está instalado. Saltando dependencias de ML', 'yellow');
    }
  }
} else {
  console.log('');
  log('⏭️  Saltando instalación de dependencias (--skip-deps)', 'yellow');
}

// Resumen final
console.log('');
log('✨ =============================================', 'green');
log('   INICIALIZACIÓN COMPLETADA', 'green');
log('   =============================================', 'green');
console.log('');
log('📝 Próximos pasos:', 'cyan');
console.log('');
log('  1️⃣  Configurar variables de entorno:', 'cyan');
log('     - EstacionCafe-Backend/DB_CREDENTIALS.env', 'cyan');
log('     - EstacionCafe-Backend/SECURITY_CREDENTIALS.env', 'cyan');
console.log('');
log('  2️⃣  Levantar servicios con Docker:', 'cyan');
log('     npm start', 'yellow');
log('     (o: npm run start:build para reconstruir)', 'yellow');
console.log('');
log('  3️⃣  Acceder a los servicios:', 'cyan');
log('     Frontend:     http://localhost:4321', 'cyan');
log('     Backend API:  http://localhost:3484', 'cyan');
log('     ML Dashboard: http://localhost:8000', 'cyan');
log('     Email:        http://localhost:3004', 'cyan');
console.log('');
log('💡 Comandos útiles:', 'cyan');
log('   Ver logs:           npm run logs', 'cyan');
log('   Ver estado:         npm run status', 'cyan');
log('   Detener servicios:  npm stop', 'cyan');
log('   Reiniciar:          npm restart', 'cyan');
console.log('');
log('📖 Para más información, consulta el README.md', 'cyan');
console.log('');
