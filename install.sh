#!/bin/bash

# 🍳 Recetas del Mundo - Script de Instalación Automática
# Este script instala y configura la aplicación automáticamente

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
    echo -e "${BLUE}  🍳 Recetas del Mundo         ${NC}"
    echo -e "${BLUE}     Instalación Automática    ${NC}"
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

# Función para verificar MySQL
check_mysql() {
    print_message "Verificando MySQL..."
    
    if command_exists mysql; then
        print_message "✅ MySQL encontrado"
        
        # Verificar si MySQL está ejecutándose
        if mysqladmin ping -h localhost -u root --silent 2>/dev/null || \
           mysqladmin ping -h localhost -u agrouser -pagropass --silent 2>/dev/null; then
            print_message "✅ MySQL está ejecutándose"
            return 0
        else
            print_warning "⚠️  MySQL no está ejecutándose. Intentando iniciar..."
            # Intentar iniciar MySQL (varía según el sistema)
            if [[ "$OSTYPE" == "linux-gnu"* ]]; then
                sudo systemctl start mysql 2>/dev/null || sudo service mysql start 2>/dev/null || true
            elif [[ "$OSTYPE" == "darwin"* ]]; then
                brew services start mysql 2>/dev/null || true
            fi
            sleep 2
            return 0
        fi
    else
        print_warning "⚠️  MySQL no encontrado. Se intentará instalar..."
        return 1
    fi
}

# Función para instalar MySQL (Ubuntu/Debian)
install_mysql_ubuntu() {
    print_message "Instalando MySQL..."
    sudo apt update
    sudo apt install -y mysql-server
    sudo systemctl start mysql
    sudo systemctl enable mysql
    print_message "✅ MySQL instalado"
}

# Función para instalar MySQL (macOS)
install_mysql_macos() {
    print_message "Instalando MySQL con Homebrew..."
    if command_exists brew; then
        brew install mysql
        brew services start mysql
        print_message "✅ MySQL instalado"
    else
        print_error "❌ Homebrew no encontrado"
        return 1
    fi
}

# Función para configurar base de datos
setup_database() {
    print_message "Configurando base de datos MySQL..."
    
    # Intentar crear base de datos y usuario
    mysql -u root -p${MYSQL_ROOT_PASSWORD:-root} << EOF 2>/dev/null || \
    mysql -u root << EOF 2>/dev/null || \
    mysql -u agrouser -pagropass << EOF 2>/dev/null || true
    
CREATE DATABASE IF NOT EXISTS agrorent;
CREATE USER IF NOT EXISTS 'agrouser'@'localhost' IDENTIFIED BY 'agropass';
GRANT ALL PRIVILEGES ON agrorent.* TO 'agrouser'@'localhost';
FLUSH PRIVILEGES;
EOF

    # Ejecutar scripts SQL
    if [ -f "src/main/resources/schema.sql" ]; then
        print_message "Ejecutando schema.sql..."
        mysql -u agrouser -pagropass agrorent < src/main/resources/schema.sql 2>/dev/null || \
        mysql -u root -p${MYSQL_ROOT_PASSWORD:-root} agrorent < src/main/resources/schema.sql 2>/dev/null || \
        mysql -u root agrorent < src/main/resources/schema.sql 2>/dev/null || true
    fi
    
    if [ -f "src/main/resources/data.sql" ]; then
        print_message "Ejecutando data.sql..."
        mysql -u agrouser -pagropass agrorent < src/main/resources/data.sql 2>/dev/null || \
        mysql -u root -p${MYSQL_ROOT_PASSWORD:-root} agrorent < src/main/resources/data.sql 2>/dev/null || \
        mysql -u root agrorent < src/main/resources/data.sql 2>/dev/null || true
    fi
    
    print_message "✅ Base de datos configurada"
}

# Función para ejecutar el proyecto
run_project() {
    print_message "Iniciando aplicación..."
    print_message "La aplicación estará disponible en: http://localhost:8080/recetas"
    print_message ""
    print_message "Cuentas de prueba:"
    print_message "- Admin: admin / admin"
    print_message "- Usuario: juan / juan"
    print_message "- Usuario: maria / maria"
    print_message ""
    print_message "APIs disponibles:"
    print_message "- POST /api/auth/login - Login (retorna JWT)"
    print_message "- GET /api/recipes/home - Recetas recientes y populares"
    print_message "- GET /api/recipes/search - Búsqueda de recetas"
    print_message "- GET /api/recipes/{id} - Detalles (requiere JWT)"
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
    
    # Verificar y configurar MySQL
    OS=$(detect_os)
    if ! check_mysql; then
        print_warning "MySQL no encontrado. ¿Instalarlo automáticamente? (y/n)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            case $OS in
                "ubuntu")
                    install_mysql_ubuntu
                    ;;
                "macos")
                    install_mysql_macos
                    ;;
                *)
                    print_error "❌ No se puede instalar MySQL automáticamente en este sistema"
                    print_message "Por favor, instala MySQL manualmente y ejecuta este script nuevamente"
                    exit 1
                    ;;
            esac
        else
            print_warning "⚠️  MySQL no configurado. Asegúrate de tener MySQL instalado y ejecutándose."
            print_message "Cuando MySQL esté listo, ejecuta manualmente:"
            print_message "  mysql -u root -p < src/main/resources/schema.sql"
            print_message "  mysql -u root -p < src/main/resources/data.sql"
        fi
    else
        # Configurar base de datos
        setup_database
    fi
    
    # Compilar proyecto
    compile_project
    
    # Preguntar si ejecutar
    print_message "¿Deseas ejecutar la aplicación ahora? (y/n)"
    read -r response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        run_project
    else
        print_message "✅ Instalación completada. Ejecuta 'mvn spring-boot:run' para iniciar la aplicación."
    fi
}

# Ejecutar función principal
main "$@"
