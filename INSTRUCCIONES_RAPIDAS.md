# 🚀 Instrucciones Rápidas de Ejecución

## 📥 Clonar el Repositorio

```bash
git clone https://github.com/Gutska90/Agro-rent.git
cd agro-rent
```

## 🎯 Opción Rápida: Script Automático

```bash
chmod +x install.sh
./install.sh
```

El script automáticamente:
- ✅ Verifica Java 17+ y Maven
- ✅ Instala dependencias si faltan
- ✅ Configura MySQL (si no está instalado)
- ✅ Crea la base de datos y usuario
- ✅ Ejecuta los scripts SQL
- ✅ Compila el proyecto
- ✅ Ejecuta la aplicación

## 📋 Opción Manual: Pasos Rápidos

### 1. Verificar Requisitos

```bash
java -version  # Debe ser JDK 17+
mvn -version   # Debe ser Maven 3.6+
mysql --version # Debe ser MySQL 8.0+
```

### 2. Configurar Base de Datos MySQL

```bash
# Crear base de datos y usuario
mysql -u root -p << EOF
CREATE DATABASE IF NOT EXISTS agrorent;
CREATE USER IF NOT EXISTS 'agrouser'@'localhost' IDENTIFIED BY 'agropass';
GRANT ALL PRIVILEGES ON agrorent.* TO 'agrouser'@'localhost';
FLUSH PRIVILEGES;
EOF

# Ejecutar scripts SQL
mysql -u agrouser -pagropass agrorent < src/main/resources/schema.sql
mysql -u agrouser -pagropass agrorent < src/main/resources/data.sql
```

### 3. Ejecutar la Aplicación

```bash
mvn clean compile
mvn spring-boot:run
```

### 4. Acceder a la Aplicación

- **URL Principal**: http://localhost:8080/recetas/
- **Login**: http://localhost:8080/recetas/login

## 👥 Cuentas de Prueba

| Usuario | Contraseña | Rol |
|---------|------------|-----|
| admin | admin | Admin |
| juan | juan | Usuario |
| maria | maria | Usuario |

## 🔗 APIs Disponibles

### Públicas (Sin Autenticación)
- `GET /api/recipes/home` - Recetas recientes y populares
- `GET /api/recipes/search?name=...&cuisineType=...` - Búsqueda de recetas
- `POST /api/auth/login` - Login que retorna token JWT

### Privadas (Requieren JWT)
- `GET /api/recipes/{id}` - Detalles completos (requiere header `Authorization: Bearer {token}`)

### Ejemplo de Login API

```bash
curl -X POST http://localhost:8080/recetas/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","password":"admin"}'
```

## ⚙️ Configuración de Base de Datos

Si necesitas cambiar la configuración de MySQL, edita `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:mysql://localhost:3306/agrorent?...
spring.datasource.username=agrouser
spring.datasource.password=agropass
```

## 🐛 Solución Rápida de Problemas

### Error: Puerto 8080 en uso
```bash
lsof -ti:8080 | xargs kill -9
```

### Error: MySQL no conecta
```bash
# Verificar que MySQL esté ejecutándose
sudo systemctl status mysql  # Linux
brew services list | grep mysql  # macOS

# Reiniciar MySQL si es necesario
sudo systemctl restart mysql  # Linux
brew services restart mysql  # macOS
```

### Error: Base de datos no existe
```bash
mysql -u root -p < src/main/resources/schema.sql
mysql -u root -p < src/main/resources/data.sql
```

## 📚 Documentación Completa

Para más detalles, consulta el archivo `README.md`

---

**¡Listo para ejecutar!** 🎉

