# 🌾 AgroRent - Sistema de Arrendamiento de Maquinaria Agrícola

Una aplicación web segura desarrollada con Spring Boot, Spring Security y Thymeleaf para el arrendamiento de maquinaria agrícola entre propietarios y agricultores.

## 📋 Descripción del Proyecto

**AgroRent** es una plataforma web que permite a los propietarios de maquinaria agrícola monetizar sus equipos ociosos, mientras que los agricultores pueden acceder a maquinaria especializada sin realizar grandes inversiones. La aplicación cuenta con un diseño intuitivo y funcional que facilita la búsqueda, publicación y reserva de maquinaria agrícola.

## 🚀 Características Principales

### Páginas Públicas
- **Página de Inicio**: Información agrícola, eventos, fechas de cosecha y maquinaria destacada
- **Búsqueda de Maquinaria**: Filtros avanzados por tipo, ubicación, precio y fechas disponibles
- **Registro de Usuarios**: Sistema de registro con validaciones
- **Login**: Autenticación segura con Spring Security

### Páginas Privadas (Requieren Autenticación)
- **Dashboard**: Panel de control con acceso rápido a todas las funcionalidades
- **Perfil de Usuario**: Gestión de información personal (dirección, teléfono, cultivos)
- **Publicación de Maquinaria**: Formulario completo para publicar equipos
- **Detalles de Maquinaria**: Información detallada de cada equipo disponible

### Seguridad
- **Spring Security** con protección de URLs
- **Autenticación** con BCrypt para contraseñas
- **Autorización** diferenciada para páginas públicas/privadas
- **Context path** configurado como `/recetas`

## 🛠️ Tecnologías Utilizadas

- **Backend**: Spring Boot 3.3.4
- **Seguridad**: Spring Security
- **Frontend**: Thymeleaf + HTML5 + CSS3
- **Base de Datos**: H2 (desarrollo) / MySQL (producción)
- **ORM**: Spring Data JPA
- **Build Tool**: Maven
- **Java**: JDK 17
- **Contenedores**: Docker & Docker Compose

## 📦 Requisitos del Sistema

### Requisitos Mínimos
- **Java**: JDK 17 o superior
- **Maven**: 3.6+ 
- **Memoria**: 2GB RAM mínimo
- **Espacio**: 500MB de espacio libre

### Requisitos Opcionales (Para Producción)
- **Docker**: 20.10+
- **Docker Compose**: 2.0+
- **MySQL**: 8.0+ (para producción)

## 🚀 Instalación y Configuración

### Opción 1: Ejecución Directa (Recomendado para Desarrollo)

1. **Clonar el repositorio**
   ```bash
   git clone <URL_DEL_REPOSITORIO>
   cd agro-rent
   ```

2. **Verificar Java y Maven**
   ```bash
   java -version  # Debe ser JDK 17+
   mvn -version   # Debe ser Maven 3.6+
   ```

3. **Compilar y ejecutar**
   ```bash
   mvn clean compile
   mvn spring-boot:run
   ```

4. **Acceder a la aplicación**
   - URL: http://localhost:8080
   - Context path: http://localhost:8080/recetas

### Opción 2: Con Docker (Para Producción)

1. **Ejecutar con Docker Compose**
   ```bash
   docker-compose up --build -d
   ```

2. **Acceder a la aplicación**
   - URL: http://localhost:8080/recetas

### Opción 3: Script de Instalación Automática

1. **Dar permisos de ejecución**
   ```bash
   chmod +x install.sh
   ```

2. **Ejecutar instalación**
   ```bash
   ./install.sh
   ```

## 👥 Cuentas de Prueba

La aplicación incluye 3 usuarios predefinidos para pruebas:

| Usuario | Email | Contraseña | Rol |
|---------|-------|------------|-----|
| Admin | admin@agro.cl | 123456 | Administrador |
| Juan | juan@agro.cl | 123456 | Usuario |
| María | maria@agro.cl | 123456 | Usuario |

## 🗄️ Base de Datos

### Desarrollo (H2)
- **URL**: http://localhost:8080/h2-console
- **JDBC URL**: `jdbc:h2:file:./data/agrodb`
- **Usuario**: `sa`
- **Contraseña**: (vacía)

### Producción (MySQL)
- **Host**: localhost:3306
- **Base de datos**: agrorent
- **Usuario**: agrouser
- **Contraseña**: agropass

## 📁 Estructura del Proyecto

```
agro-rent/
├── src/
│   ├── main/
│   │   ├── java/cl/duoc/agro/
│   │   │   ├── AgroRentApplication.java
│   │   │   ├── config/
│   │   │   │   └── SecurityConfig.java
│   │   │   ├── dto/
│   │   │   │   └── RegisterDto.java
│   │   │   ├── model/
│   │   │   │   ├── User.java
│   │   │   │   ├── Role.java
│   │   │   │   ├── Machinery.java
│   │   │   │   └── Reservation.java
│   │   │   ├── repo/
│   │   │   │   ├── UserRepository.java
│   │   │   │   ├── RoleRepository.java
│   │   │   │   └── MachineryRepository.java
│   │   │   ├── service/
│   │   │   │   └── AppUserDetailsService.java
│   │   │   └── web/
│   │   │       ├── HomeController.java
│   │   │       ├── AuthController.java
│   │   │       ├── MachineryController.java
│   │   │       └── ProfileController.java
│   │   └── resources/
│   │       ├── application.properties
│   │       ├── application-prod.properties
│   │       ├── data.sql
│   │       ├── schema.sql
│   │       ├── static/css/
│   │       │   └── main.css
│   │       └── templates/
│   │           ├── home.html
│   │           ├── login.html
│   │           ├── register.html
│   │           ├── dashboard.html
│   │           ├── profile.html
│   │           ├── machinery-search.html
│   │           ├── machinery-detail.html
│   │           └── machinery-form.html
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

### Configuración de Base de Datos

#### Desarrollo (application.properties)
```properties
spring.datasource.url=jdbc:h2:file:./data/agrodb
spring.datasource.username=sa
spring.datasource.password=
spring.h2.console.enabled=true
```

#### Producción (application-prod.properties)
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/agrorent
spring.datasource.username=agrouser
spring.datasource.password=agropass
```

## 🧪 Pruebas

### Pruebas Manuales

1. **Página de inicio**: Verificar carga de información agrícola
2. **Búsqueda**: Probar filtros de maquinaria
3. **Registro**: Crear nuevo usuario
4. **Login**: Autenticarse con cuentas de prueba
5. **Dashboard**: Acceder a funcionalidades privadas
6. **Perfil**: Actualizar información personal
7. **Publicación**: Crear nueva maquinaria

### Pruebas Automáticas
```bash
mvn test
```

## 🐛 Solución de Problemas

### Error: "Java version not found"
```bash
# Verificar instalación de Java
java -version
# Si no está instalado, instalar JDK 17
```

### Error: "Maven not found"
```bash
# Verificar instalación de Maven
mvn -version
# Si no está instalado, instalar Maven 3.6+
```

### Error: "Port 8080 already in use"
```bash
# Detener proceso en puerto 8080
lsof -ti:8080 | xargs kill -9
# O cambiar puerto en application.properties
```

### Error: "Database connection failed"
```bash
# Verificar que H2 esté funcionando
# Acceder a http://localhost:8080/h2-console
```

## 📝 Funcionalidades Implementadas

### ✅ Completadas
- [x] Sistema de autenticación con Spring Security
- [x] Páginas públicas (inicio, búsqueda, login, registro)
- [x] Páginas privadas (dashboard, perfil, publicación)
- [x] Base de datos con datos de prueba
- [x] Diseño CSS moderno y responsive
- [x] Context path `/recetas` configurado
- [x] Docker y Docker Compose para despliegue
- [x] Documentación completa

### 🔄 Futuras Mejoras
- [ ] Sistema de reservas completo
- [ ] Notificaciones por email
- [ ] Panel de administración avanzado
- [ ] API REST para móviles
- [ ] Sistema de pagos integrado
- [ ] Geolocalización de maquinaria

## 🤝 Contribución

1. Fork el proyecto
2. Crear una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abrir un Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 👨‍💻 Autores

- **Equipo AgroRent** - Desarrollo inicial

## 📞 Soporte

Si tienes problemas o preguntas:

1. Revisar la sección de [Solución de Problemas](#-solución-de-problemas)
2. Verificar los [Requisitos del Sistema](#-requisitos-del-sistema)
3. Crear un issue en el repositorio

## 🎯 Objetivos del Proyecto

Este proyecto cumple con los siguientes objetivos académicos:

- ✅ Desarrollo de aplicación web segura con Spring Boot
- ✅ Implementación de Spring Security para autenticación
- ✅ Uso de Thymeleaf para el frontend
- ✅ Protección de URLs públicas y privadas
- ✅ Sistema de usuarios con al menos 3 cuentas
- ✅ Diseño CSS funcional y atractivo
- ✅ Context path configurado como `/recetas`
- ✅ Preparado para despliegue en máquina virtual

---

**¡Gracias por usar AgroRent! 🌾**