# Instrucciones para Configurar Oracle Database

## Requisitos Previos

1. Oracle Database 11g o superior instalado
2. Usuario con permisos CREATE TABLE, CREATE SEQUENCE, CREATE TRIGGER
3. SQL*Plus, SQL Developer o herramienta similar

## Paso 1: Crear Usuario (Opcional)

Si necesitas crear un usuario específico para la aplicación:

```sql
-- Conectar como SYSDBA
sqlplus sys/password@localhost:1521/XE as sysdba

-- Crear usuario
CREATE USER recetas_user IDENTIFIED BY recetas_pass;

-- Otorgar permisos
GRANT CONNECT, RESOURCE TO recetas_user;
GRANT CREATE SESSION TO recetas_user;
GRANT UNLIMITED TABLESPACE TO recetas_user;

-- Salir
EXIT;
```

## Paso 2: Ejecutar Script SQL

### Opción A: Desde SQL*Plus

```bash
sqlplus recetas_user/recetas_pass@localhost:1521/XE @scripts-bbdd/schema-oracle.sql
```

### Opción B: Desde SQL Developer

1. Abrir SQL Developer
2. Conectar a la base de datos
3. Abrir el archivo `scripts-bbdd/schema-oracle.sql`
4. Ejecutar todo el script (F5 o botón "Run Script")

### Opción C: Copiar y Pegar

1. Abrir SQL*Plus o SQL Developer
2. Conectar a la base de datos
3. Copiar el contenido de `schema-oracle.sql`
4. Pegar y ejecutar

## Paso 3: Verificar Instalación

```sql
-- Verificar tablas creadas
SELECT table_name FROM user_tables 
WHERE table_name IN ('ROLES', 'USUARIOS', 'RECETAS', 'COMENTARIOS', 'VALORACIONES')
ORDER BY table_name;

-- Verificar datos
SELECT 'Roles' as tabla, COUNT(*) as cantidad FROM roles
UNION ALL
SELECT 'Usuarios', COUNT(*) FROM usuarios
UNION ALL
SELECT 'Recetas', COUNT(*) FROM recetas;

-- Verificar secuencias
SELECT sequence_name FROM user_sequences;
```

## Paso 4: Configurar Aplicación Spring Boot

### Opción A: Modificar application.properties

Editar `src/main/resources/application.properties`:

```properties
spring.datasource.url=jdbc:oracle:thin:@localhost:1521:XE
spring.datasource.username=recetas_user
spring.datasource.password=recetas_pass
spring.datasource.driver-class-name=oracle.jdbc.driver.OracleDriver
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.OracleDialect
```

### Opción B: Usar Variables de Entorno

```bash
export DB_URL="jdbc:oracle:thin:@localhost:1521:XE"
export DB_USERNAME="recetas_user"
export DB_PASSWORD="recetas_pass"
```

Y en `application.properties`:
```properties
spring.datasource.url=${DB_URL}
spring.datasource.username=${DB_USERNAME}
spring.datasource.password=${DB_PASSWORD}
```

## Paso 5: Agregar Dependencia Oracle (si no está)

Si el proyecto no tiene la dependencia de Oracle, agregar al `pom.xml`:

```xml
<dependency>
    <groupId>com.oracle.database.jdbc</groupId>
    <artifactId>ojdbc11</artifactId>
    <scope>runtime</scope>
</dependency>
```

## Diferencias Clave con MySQL

### 1. Auto-increment
- **MySQL:** Usa `AUTO_INCREMENT`
- **Oracle:** Usa secuencias + triggers

### 2. Tipos de Datos
- **MySQL:** `BIGINT`, `VARCHAR`, `TEXT`
- **Oracle:** `NUMBER(19)`, `VARCHAR2`, `CLOB`

### 3. Booleanos
- **MySQL:** `TINYINT(1)`
- **Oracle:** `NUMBER(1)` con CHECK constraint

### 4. Strings Multilínea
- **MySQL:** `\n` en strings
- **Oracle:** `CHR(10)` o `|| CHR(10) ||`

## Solución de Problemas

### Error: "ORA-00942: table or view does not exist"
- Verificar que el script se ejecutó completamente
- Verificar que estás conectado con el usuario correcto

### Error: "ORA-00955: name is already in use"
- Las tablas ya existen, ejecutar primero los DROP statements
- O usar el script completo que incluye DROP statements

### Error: "ORA-01031: insufficient privileges"
- El usuario no tiene permisos suficientes
- Otorgar permisos: `GRANT RESOURCE, CREATE SESSION TO usuario;`

### Error: "ORA-00922: missing or invalid option"
- Verificar sintaxis SQL
- Algunas versiones de Oracle pueden requerir sintaxis diferente

### Error de Conexión
- Verificar que el servicio Oracle está ejecutándose
- Verificar TNS names o connection string
- Probar conexión con: `tnsping XE` (si usa TNS)

## Notas Importantes

1. **Case Sensitivity:** Oracle convierte nombres de tablas a mayúsculas por defecto. Los modelos JPA deben usar `@Table(name = "USUARIOS")` o configurar quoting.

2. **Secuencias:** Las secuencias se crean automáticamente. Si necesitas resetear una secuencia:
   ```sql
   ALTER SEQUENCE usuarios_seq RESTART START WITH 1;
   ```

3. **Triggers:** Los triggers se ejecutan automáticamente al insertar. No necesitas especificar el ID manualmente.

4. **CLOB vs TEXT:** Oracle usa CLOB para textos largos. JPA maneja esto automáticamente con `@Lob`.

## Verificación Final

Después de configurar todo, iniciar la aplicación:

```bash
mvn spring-boot:run
```

Si hay errores de conexión, verificar:
- URL de conexión
- Credenciales
- Que el servicio Oracle esté ejecutándose
- Que el usuario tenga los permisos necesarios

