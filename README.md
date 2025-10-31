# 🍳 Recetas del Mundo - Aplicación Web Segura con JWT

Una aplicación web segura desarrollada con Spring Boot, Spring Security, Thymeleaf y autenticación JWT para compartir y descubrir recetas culinarias de todo el mundo.

## 📋 Descripción del Proyecto

**Recetas del Mundo** es una plataforma web que permite a los usuarios descubrir recetas culinarias internacionales. Los visitantes pueden buscar recetas por múltiples criterios, y los usuarios autenticados pueden ver los detalles completos incluyendo ingredientes, instrucciones y fotografías.

## 🚀 Características Principales

### Páginas Públicas
- **Página de Inicio**: Recetas más recientes y populares, banners publicitarios
- **Búsqueda de Recetas**: Búsqueda avanzada por nombre, tipo de cocina, país de origen, dificultad e ingredientes
- **Registro de Usuarios**: Sistema de registro con validaciones
- **Login**: Autenticación con formulario tradicional y API JWT

### Páginas Privadas (Requieren Autenticación)
- **Detalles Completos de Recetas**: Ingredientes, instrucciones, tiempo de cocción, dificultad y fotografías

### APIs REST

#### APIs Públicas (Sin Autenticación)
- `POST /api/auth/login` - Autenticación que retorna token JWT
- `GET /api/recipes/home` - Recetas recientes y populares
- `GET /api/recipes/search` - Búsqueda de recetas con filtros

#### APIs Privadas (Requieren Token JWT)
- `GET /api/recipes/{id}` - Detalles completos de receta (requiere header `Authorization: Bearer {token}`)

## 🛠️ Tecnologías Utilizadas

- **Backend**: Spring Boot 3.3.4
- **Seguridad**: Spring Security con JWT
- **Frontend**: Thymeleaf + HTML5 + CSS3
- **Base de Datos**: MySQL 8.0+
- **ORM**: Spring Data JPA
- **Build Tool**: Maven
- **Java**: JDK 17
- **JWT**: io.jsonwebtoken (jjwt) 0.12.3
- **Contenedores**: Docker & Docker Compose (opcional)

## 📦 Requisitos del Sistema

### Requisitos Mínimos
- **Java**: JDK 17 o superior
- **Maven**: 3.6+
- **MySQL**: 8.0+ (servidor local o remoto)
- **Memoria**: 2GB RAM mínimo
- **Espacio**: 500MB de espacio libre

### Requisitos Opcionales (Para Producción)
- **Docker**: 20.10+
- **Docker Compose**: 2.0+

## 🚀 Instalación y Configuración

### Opción 1: Ejecución Directa (Recomendado para Desarrollo)

#### Paso 1: Configurar Base de Datos MySQL

```bash
# Crear base de datos y usuario
mysql -u root -p << EOF
CREATE DATABASE IF NOT EXISTS agrorent;
CREATE USER IF NOT EXISTS 'agrouser'@'localhost' IDENTIFIED BY 'agropass';
GRANT ALL PRIVILEGES ON agrorent.* TO 'agrouser'@'localhost';
FLUSH PRIVILEGES;
EOF

# Ejecutar scripts de base de datos
mysql -u agrouser -pagropass agrorent < src/main/resources/schema.sql
mysql -u agrouser -pagropass agrorent < src/main/resources/data.sql
```

#### Paso 2: Clonar y Ejecutar

```bash
# Clonar el repositorio
git clone https://github.com/Gutska90/Agro-rent.git
cd agro-rent

# Compilar el proyecto
mvn clean compile

# Ejecutar la aplicación
mvn spring-boot:run
```

#### Paso 3: Acceder a la Aplicación

- **URL Principal**: http://localhost:8080/recetas/
- **Login**: http://localhost:8080/recetas/login
- **Búsqueda**: http://localhost:8080/recetas/recipes/search

### Opción 2: Script de Instalación Automática

```bash
# Dar permisos de ejecución
chmod +x install.sh

# Ejecutar instalación (instala Java, Maven y configura BD)
./install.sh
```

### Opción 3: Con Docker Compose (Para Producción)

```bash
# Dar permisos de ejecución
chmod +x deploy.sh

# Ejecutar despliegue
./deploy.sh
```

La aplicación estará disponible en: http://localhost:8080/recetas

## 👥 Cuentas de Prueba

La aplicación incluye 3 usuarios predefinidos:

| Usuario | Email | Contraseña | Rol |
|---------|-------|------------|-----|
| Admin | admin@agro.cl | admin | Administrador |
| Juan | juan@agro.cl | juan | Usuario |
| María | maria@agro.cl | maria | Usuario |

**Nota**: También puedes usar el `username` directamente (admin, juan, maria) para hacer login.

## 🔐 Autenticación JWT

### Login con API (Obtener Token JWT)

```bash
curl -X POST http://localhost:8080/recetas/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin"}'
```

**Respuesta:**
```json
{
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "type": "Bearer",
  "username": "admin",
  "email": "admin@agro.cl",
  "role": "ROLE_ADMIN"
}
```

### Usar Token JWT en APIs Privadas

```bash
curl -X GET http://localhost:8080/recetas/api/recipes/1 \
  -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
```

## 🗄️ Base de Datos

### Configuración MySQL

- **Host**: localhost:3306
- **Base de datos**: agrorent
- **Usuario**: agrouser
- **Contraseña**: agropass

### Estructura de Tablas

- `users` - Usuarios del sistema
- `roles` - Roles (ROLE_USER, ROLE_ADMIN)
- `user_roles` - Relación usuarios-roles
- `recipes` - Recetas culinarias
- `machinery` - Maquinaria (legacy)
- `reservations` - Reservas (legacy)

### Datos Iniciales

- **3 usuarios** de prueba
- **10 recetas** de ejemplo de diferentes países y tipos de cocina

## 📁 Estructura del Proyecto

```
agro-rent/
├── src/
│   ├── main/
│   │   ├── java/cl/duoc/agro/
│   │   │   ├── AgroRentApplication.java
│   │   │   ├── config/
│   │   │   │   ├── JwtSecurityConfig.java
│   │   │   │   └── JwtAuthenticationFilter.java
│   │   │   ├── dto/
│   │   │   │   ├── LoginRequest.java
│   │   │   │   ├── LoginResponse.java
│   │   │   │   └── RecipeDTO.java
│   │   │   ├── model/
│   │   │   │   ├── User.java
│   │   │   │   ├── Role.java
│   │   │   │   ├── Recipe.java
│   │   │   │   ├── Machinery.java
│   │   │   │   └── Reservation.java
│   │   │   ├── repo/
│   │   │   │   ├── UserRepository.java
│   │   │   │   ├── RecipeRepository.java
│   │   │   │   └── MachineryRepository.java
│   │   │   ├── service/
│   │   │   │   ├── OptimizedUserDetailsService.java
│   │   │   │   └── JwtService.java
│   │   │   └── web/
│   │   │       ├── HomeController.java
│   │   │       ├── RecipeController.java
│   │   │       ├── AuthController.java
│   │   │       ├── AuthRestController.java
│   │   │       ├── RecipeRestController.java
│   │   │       ├── MachineryController.java
│   │   │       └── ProfileController.java
│   │   └── resources/
│   │       ├── application.properties
│   │       ├── application-prod.properties
│   │       ├── schema.sql
│   │       ├── data.sql
│   │       ├── static/css/
│   │       │   └── main.css
│   │       └── templates/
│   │           ├── home.html
│   │           ├── login.html
│   │           ├── register.html
│   │           ├── recipe-search.html
│   │           ├── recipe-detail.html
│   │           ├── dashboard.html
│   │           ├── profile.html
│   │           └── machinery-*.html
├── docker-compose.yml
├── Dockerfile
├── pom.xml
├── README.md
├── install.sh
└── deploy.sh
```

## 🔧 Configuración

### Variables de Entorno (Opcional)

```bash
export SPRING_PROFILES_ACTIVE=dev
export SERVER_PORT=8080
export SERVER_SERVLET_CONTEXT_PATH=/recetas
```

### Configuración de Base de Datos (application.properties)

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/agrorent?createDatabaseIfNotExist=true&useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
spring.datasource.username=agrouser
spring.datasource.password=agropass

# Configuración JWT
jwt.secret=mySecretKey123456789012345678901234567890123456789012345678901234567890
jwt.expiration=86400000
```

## 🧪 Pruebas

### Pruebas Manuales

1. **Página de inicio**: Verificar carga de recetas recientes y populares
2. **Búsqueda**: Probar filtros de recetas (nombre, tipo, país, dificultad, ingredientes)
3. **Registro**: Crear nuevo usuario
4. **Login**: Autenticarse con cuentas de prueba
5. **Login API**: Obtener token JWT usando la API
6. **Detalles**: Ver detalles completos de receta (requiere autenticación)

### Probar API de Login

```bash
# Login y obtener token
curl -X POST http://localhost:8080/recetas/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin"}'

# Usar token para acceder a detalles de receta
curl -X GET http://localhost:8080/recetas/api/recipes/1 \
  -H "Authorization: Bearer [TU_TOKEN_AQUI]"
```

## 📝 Funcionalidades Implementadas

### ✅ Completadas

- ✅ Sistema de autenticación JWT completo
- ✅ APIs REST públicas y privadas
- ✅ Página de inicio con recetas recientes y populares
- ✅ Búsqueda avanzada de recetas (pública)
- ✅ Visualización de detalles de recetas (privada con JWT)
- ✅ Base de datos MySQL con datos de prueba
- ✅ Diseño CSS moderno y responsive
- ✅ Context path `/recetas` configurado
- ✅ Protección de URLs (públicas/privadas)
- ✅ Docker y Docker Compose para despliegue
- ✅ Scripts de instalación automatizados
- ✅ Documentación completa

## 🐛 Solución de Problemas

### Error: "Port 8080 already in use"

```bash
# Detener proceso en puerto 8080
lsof -ti:8080 | xargs kill -9
# O cambiar puerto en application.properties
```

### Error: "Database connection failed"

```bash
# Verificar que MySQL esté ejecutándose
sudo systemctl status mysql  # Linux
brew services list | grep mysql  # macOS

# Verificar credenciales en application.properties
# Ejecutar scripts de base de datos manualmente
mysql -u agrouser -pagropass agrorent < src/main/resources/schema.sql
mysql -u agrouser -pagropass agrorent < src/main/resources/data.sql
```

### Error: "Java version not found"

```bash
# Verificar instalación de Java
java -version

# Si no está instalado, usar el script install.sh
./install.sh
```

### Error 403: Acceso Denegado

- Verifica que estés usando las URLs correctas
- Para APIs privadas, asegúrate de incluir el token JWT en el header `Authorization: Bearer {token}`
- Verifica que el usuario tenga los roles correctos

## 🎯 Objetivos del Proyecto

Este proyecto cumple con los siguientes objetivos académicos:

- ✅ Desarrollo de aplicación web segura con Spring Boot
- ✅ Implementación de Spring Security con JWT
- ✅ Uso de Thymeleaf para el frontend
- ✅ Protección de URLs públicas y privadas
- ✅ Sistema de autenticación con al menos 3 usuarios
- ✅ API de login que retorna token JWT
- ✅ APIs privadas protegidas con JWT
- ✅ Datos obtenidos desde MySQL
- ✅ Diseño CSS funcional y atractivo
- ✅ Context path configurado como `/recetas`
- ✅ Preparado para despliegue en máquina virtual

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 Autores

- **Equipo AgroRent** - Desarrollo inicial

## 📞 Soporte

Si tienes problemas o preguntas:

1. Revisar la sección de Solución de Problemas
2. Verificar los Requisitos del Sistema
3. Crear un issue en el repositorio: https://github.com/Gutska90/Agro-rent

---

**¡Gracias por usar Recetas del Mundo! 🍳**
