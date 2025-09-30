#!/bin/bash
# Script de instalación de ECFDR en Docker ERPNext
# Copyright (c) 2025, Navari Ltd and contributors

set -e

echo "🐳 Instalando ECFDR en ERPNext Docker..."
echo "=========================================="

# Verificar que estamos en el contenedor correcto
if [ ! -f "/home/frappe/frappe-bench/current/frappe/frappe/__init__.py" ]; then
    echo "❌ Error: No se detectó entorno Frappe/ERPNext"
    exit 1
fi

# Navegar al directorio del bench
cd /home/frappe/frappe-bench

echo "📁 Preparando directorio para ECFDR..."
mkdir -p apps/csf_do

echo "📋 Copiando archivos de ECFDR..."
cp -r /tmp/csf_do/* apps/csf_do/

echo "⚙️ Instalando ECFDR como aplicación..."
# Instalar la aplicación usando bench
bench get-app --branch main file:///tmp/csf_do

echo "🔧 Instalando ECFDR en el sitio..."
# Instalar en el sitio
bench --site all install-app csf_do

echo "🔄 Ejecutando migraciones..."
# Ejecutar migraciones
bench --site all migrate

echo "🔧 Configurando permisos..."
# Configurar permisos
bench --site all set-admin-password admin

echo "🔄 Reiniciando servicios..."
# Reiniciar servicios
bench restart

echo "✅ ECFDR instalado exitosamente en ERPNext Docker!"
echo "🌐 Accede a tu ERPNext en: http://localhost:8000"
echo "👤 Usuario: Administrator"
echo "🔑 Contraseña: admin"
echo "📋 Módulo ECFDR disponible en el menú principal"
echo "=========================================="



