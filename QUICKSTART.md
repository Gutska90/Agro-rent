# 🚀 AgroRent - Instrucciones Rápidas

## Instalación en 3 pasos

### 1. Clonar el repositorio
```bash
git clone <URL_DEL_REPOSITORIO>
cd agro-rent
```

### 2. Ejecutar instalación automática
```bash
chmod +x install.sh
./install.sh
```

### 3. Acceder a la aplicación
- **URL**: http://localhost:8080/recetas
- **Login**: admin@agro.cl / 123456

## Alternativas de instalación

### Opción A: Maven directo
```bash
mvn clean compile
mvn spring-boot:run
```

### Opción B: Docker
```bash
chmod +x deploy.sh
./deploy.sh
```

## Cuentas de prueba
- **Admin**: admin@agro.cl / 123456
- **Usuario**: juan@agro.cl / 123456
- **Usuario**: maria@agro.cl / 123456

## Requisitos mínimos
- Java 17+
- Maven 3.6+
- 2GB RAM

## Solución de problemas
- **Puerto ocupado**: `lsof -ti:8080 | xargs kill -9`
- **Java no encontrado**: Instalar JDK 17
- **Maven no encontrado**: Instalar Maven 3.6+

## URLs importantes
- **Inicio**: http://localhost:8080/
- **Búsqueda**: http://localhost:8080/machinery
- **Login**: http://localhost:8080/login
- **Registro**: http://localhost:8080/register
- **Dashboard**: http://localhost:8080/dashboard (requiere login)

---
**¡Listo para usar! 🌾**
