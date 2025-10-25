#!/bin/bash

# 🌾 AgroRent - Script de Instalación Automática
# Este script instala y configura AgroRent automáticamente

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
    echo -e "${BLUE}  🌾 AgroRent - Instalación     ${NC}"
    echo -e "${BLUE}================================${NC}"
}

# Función para verificar si un comando existe
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Función para verificar Java
check_java() {
    print_message "Verificando Java..."
    
    if command_exists java; then
        JAVA_VERSION=$(java -version 2>&1 | head -n 1 | cut -d'"' -f2 | cut -d'.' -f1)
        if [ "$JAVA_VERSION" -ge 17 ]; then
            print_message "✅ Java $JAVA_VERSION encontrado"
            return 0
        else
            print_error "❌ Java $JAVA_VERSION encontrado, pero se requiere Java 17+"
            return 1
        fi
    else
        print_error "❌ Java no encontrado"
        return 1
    fi
}

# Función para verificar Maven
check_maven() {
    print_message "Verificando Maven..."
    
    if command_exists mvn; then
        MAVEN_VERSION=$(mvn -version | head -n 1 | cut -d' ' -f3)
        print_message "✅ Maven $MAVEN_VERSION encontrado"
        return 0
    else
        print_error "❌ Maven no encontrado"
        return 1
    fi
}

# Función para instalar Java (Ubuntu/Debian)
install_java_ubuntu() {
    print_message "Instalando Java 17..."
    sudo apt update
    sudo apt install -y openjdk-17-jdk
    print_message "✅ Java 17 instalado"
}

# Función para instalar Maven (Ubuntu/Debian)
install_maven_ubuntu() {
    print_message "Instalando Maven..."
    sudo apt install -y maven
    print_message "✅ Maven instalado"
}

# Función para instalar Java (macOS)
install_java_macos() {
    print_message "Instalando Java 17 con Homebrew..."
    if command_exists brew; then
        brew install openjdk@17
        print_message "✅ Java 17 instalado"
    else
        print_error "❌ Homebrew no encontrado. Instala Homebrew primero: https://brew.sh/"
        return 1
    fi
}

# Función para instalar Maven (macOS)
install_maven_macos() {
    print_message "Instalando Maven con Homebrew..."
    if command_exists brew; then
        brew install maven
        print_message "✅ Maven instalado"
    else
        print_error "❌ Homebrew no encontrado. Instala Homebrew primero: https://brew.sh/"
        return 1
    fi
}

# Función para detectar el sistema operativo
detect_os() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        if [ -f /etc/debian_version ]; then
            echo "ubuntu"
        else
            echo "linux"
        fi
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macos"
    else
        echo "unknown"
    fi
}

# Función para instalar dependencias según el OS
install_dependencies() {
    OS=$(detect_os)
    
    case $OS in
        "ubuntu")
            print_message "Sistema operativo detectado: Ubuntu/Debian"
            
            if ! check_java; then
                install_java_ubuntu
            fi
            
            if ! check_maven; then
                install_maven_ubuntu
            fi
            ;;
        "macos")
            print_message "Sistema operativo detectado: macOS"
            
            if ! check_java; then
                install_java_macos
            fi
            
            if ! check_maven; then
                install_maven_macos
            fi
            ;;
        *)
            print_error "Sistema operativo no soportado: $OSTYPE"
            print_message "Por favor instala manualmente:"
            print_message "- Java 17 o superior"
            print_message "- Maven 3.6 o superior"
            exit 1
            ;;
    esac
}

# Función para compilar el proyecto
compile_project() {
    print_message "Compilando proyecto..."
    
    if mvn clean compile; then
        print_message "✅ Proyecto compilado exitosamente"
    else
        print_error "❌ Error al compilar el proyecto"
        exit 1
    fi
}

# Función para ejecutar el proyecto
run_project() {
    print_message "Iniciando AgroRent..."
    print_message "La aplicación estará disponible en: http://localhost:8080"
    print_message "Context path: http://localhost:8080/recetas"
    print_message ""
    print_message "Cuentas de prueba:"
    print_message "- Admin: admin@agro.cl / 123456"
    print_message "- Usuario: juan@agro.cl / 123456"
    print_message "- Usuario: maria@agro.cl / 123456"
    print_message ""
    print_message "Presiona Ctrl+C para detener la aplicación"
    print_message ""
    
    mvn spring-boot:run
}

# Función principal
main() {
    print_header
    
    # Verificar si estamos en el directorio correcto
    if [ ! -f "pom.xml" ]; then
        print_error "❌ No se encontró pom.xml. Ejecuta este script desde el directorio raíz del proyecto."
        exit 1
    fi
    
    # Verificar dependencias
    print_message "Verificando dependencias del sistema..."
    
    if ! check_java || ! check_maven; then
        print_warning "Algunas dependencias faltan. ¿Instalarlas automáticamente? (y/n)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            install_dependencies
        else
            print_error "❌ Instalación cancelada. Instala las dependencias manualmente."
            exit 1
        fi
    fi
    
    # Compilar proyecto
    compile_project
    
    # Preguntar si ejecutar
    print_message "¿Deseas ejecutar AgroRent ahora? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        run_project
    else
        print_message "✅ Instalación completada. Ejecuta 'mvn spring-boot:run' para iniciar la aplicación."
    fi
}

# Ejecutar función principal
main "$@"
