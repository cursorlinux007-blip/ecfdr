#!/bin/bash
# Script para iniciar ECFDR con Docker
# Copyright (c) 2025, Navari Ltd and contributors

echo "🚀 Iniciando ECFDR con Docker..."
echo "================================="

# Verificar que Docker esté disponible
if ! command -v docker &> /dev/null; then
    echo "❌ Docker no está disponible en WSL2"
    echo "📋 Por favor:"
    echo "   1. Abre Docker Desktop en Windows"
    echo "   2. Ve a Settings → Resources → WSL Integration"
    echo "   3. Activa 'Enable integration with my default WSL distro'"
    echo "   4. Reinicia WSL2: wsl --shutdown"
    echo "   5. Vuelve a ejecutar este script"
    exit 1
fi

echo "✅ Docker detectado correctamente"

# Verificar que docker-compose esté disponible
if ! command -v docker-compose &> /dev/null; then
    echo "❌ docker-compose no está disponible"
    echo "📋 Instalando docker-compose..."
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi

echo "✅ docker-compose disponible"

# Detener contenedores existentes
echo "🔄 Deteniendo contenedores existentes..."
docker-compose down

# Iniciar los servicios
echo "🚀 Iniciando servicios de ECFDR..."
docker-compose up -d

echo "⏳ Esperando a que los servicios estén listos..."
sleep 30

# Verificar estado de los contenedores
echo "📊 Estado de los contenedores:"
docker-compose ps

echo ""
echo "✅ ECFDR iniciado correctamente!"
echo "🌐 Accede a ERPNext en: http://localhost:8000"
echo "👤 Usuario: Administrator"
echo "🔑 Contraseña: admin"
echo "📋 Módulo ECFDR disponible en el menú principal"
echo ""
echo "📋 Para ver los logs: docker-compose logs -f"
echo "🛑 Para detener: docker-compose down"
echo "================================="



