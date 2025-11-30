#!/bin/bash

# 🌾 AgroRent - Script de Despliegue con Docker
# Este script despliega AgroRent usando Docker Compose

set -e  # Salir si hay algún error

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Función para imprimir mensajes con colores
print_message() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

print_header() {
    echo -e "${BLUE}================================${NC}"
    echo -e "${BLUE}  🌾 AgroRent - Despliegue      ${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Función para verificar Docker
check_docker() {
    print_message "Verificando Docker..."
    
    if command -v docker >/dev/null 2>&1; then
        DOCKER_VERSION=$(docker --version | cut -d' ' -f3 | cut -d',' -f1)
        print_message "✅ Docker $DOCKER_VERSION encontrado"
        return 0
    else
        print_error "❌ Docker no encontrado"
        return 1
    fi
}

# Función para verificar Docker Compose
check_docker_compose() {
    print_message "Verificando Docker Compose..."
    
    if command -v docker-compose >/dev/null 2>&1; then
        COMPOSE_VERSION=$(docker-compose --version | cut -d' ' -f3 | cut -d',' -f1)
        print_message "✅ Docker Compose $COMPOSE_VERSION encontrado"
        return 0
    else
        print_error "❌ Docker Compose no encontrado"
        return 1
    fi
}

# Función para detener contenedores existentes
stop_existing() {
    print_message "Deteniendo contenedores existentes..."
    
    if docker-compose ps -q | grep -q .; then
        docker-compose down --remove-orphans
        print_message "✅ Contenedores detenidos"
    else
        print_message "ℹ️  No hay contenedores ejecutándose"
    fi
}

# Función para construir y ejecutar
build_and_run() {
    print_message "Construyendo y ejecutando AgroRent con Docker..."
    
    if docker-compose up --build -d; then
        print_message "✅ AgroRent desplegado exitosamente"
    else
        print_error "❌ Error al desplegar AgroRent"
        exit 1
    fi
}

# Función para verificar estado
check_status() {
    print_message "Verificando estado de los servicios..."
    
    # Esperar un poco para que los servicios se inicien
    sleep 10
    
    if docker-compose ps | grep -q "Up"; then
        print_message "✅ Servicios ejecutándose correctamente"
        
        # Mostrar estado de los contenedores
        echo ""
        print_message "Estado de los contenedores:"
        docker-compose ps
        
        # Mostrar logs de la aplicación
        echo ""
        print_message "Últimos logs de la aplicación:"
        docker-compose logs --tail=10 app
        
    else
        print_error "❌ Los servicios no se están ejecutando correctamente"
        print_message "Logs de error:"
        docker-compose logs
        exit 1
    fi
}

# Función para mostrar información de acceso
show_access_info() {
    echo ""
    print_message "🎉 ¡AgroRent está ejecutándose!"
    echo ""
    echo -e "${GREEN}📱 URLs de acceso:${NC}"
    echo "  • Aplicación: http://localhost:8080/recetas"
    echo "  • Página de inicio: http://localhost:8080/"
    echo "  • Búsqueda: http://localhost:8080/machinery"
    echo "  • Login: http://localhost:8080/login"
    echo ""
    echo -e "${GREEN}👥 Cuentas de prueba:${NC}"
    echo "  • Admin: admin@agro.cl / 123456"
    echo "  • Usuario: juan@agro.cl / 123456"
    echo "  • Usuario: maria@agro.cl / 123456"
    echo ""
    echo -e "${GREEN}🗄️ Base de datos:${NC}"
    echo "  • MySQL: localhost:3306"
    echo "  • Usuario: agrouser"
    echo "  • Contraseña: agropass"
    echo "  • Base de datos: agrorent"
    echo ""
    echo -e "${GREEN}🔧 Comandos útiles:${NC}"
    echo "  • Ver logs: docker-compose logs -f"
    echo "  • Detener: docker-compose down"
    echo "  • Reiniciar: docker-compose restart"
    echo "  • Estado: docker-compose ps"
}

# Función para monitorear logs
monitor_logs() {
    print_message "¿Deseas monitorear los logs en tiempo real? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        print_message "Monitoreando logs... (Presiona Ctrl+C para salir)"
        docker-compose logs -f
    fi
}

# Función principal
main() {
    print_header
    
    # Verificar si estamos en el directorio correcto
    if [ ! -f "docker-compose.yml" ]; then
        print_error "❌ No se encontró docker-compose.yml. Ejecuta este script desde el directorio raíz del proyecto."
        exit 1
    fi
    
    # Verificar dependencias
    print_message "Verificando dependencias..."
    
    if ! check_docker; then
        print_error "❌ Docker no está instalado. Instálalo desde: https://docs.docker.com/get-docker/"
        exit 1
    fi
    
    if ! check_docker_compose; then
        print_error "❌ Docker Compose no está instalado. Instálalo desde: https://docs.docker.com/compose/install/"
        exit 1
    fi
    
    # Detener contenedores existentes
    stop_existing
    
    # Construir y ejecutar
    build_and_run
    
    # Verificar estado
    check_status
    
    # Mostrar información de acceso
    show_access_info
    
    # Preguntar si monitorear logs
    monitor_logs
}

# Ejecutar función principal
main "$@"