# Guía para Ejecutar Análisis con SonarQube

## Requisitos Previos

- Java 17 o superior
- Maven 3.6 o superior
- Docker (opcional, para ejecutar SonarQube en contenedor)
- O SonarQube instalado localmente

## Paso 1: Iniciar SonarQube

### Opción A: Usando Docker (Recomendado)

```bash
# Ejecutar SonarQube en un contenedor Docker
docker run -d --name sonarqube -p 9000:9000 sonarqube:community

# Verificar que está ejecutándose
curl http://localhost:9000/api/system/status
```

### Opción B: Instalación Local

1. Descargar SonarQube Community Edition desde: https://www.sonarqube.org/downloads/
2. Extraer el archivo descargado
3. Ejecutar SonarQube:
   - **Windows**: `bin\windows-x86-64\StartSonar.bat`
   - **Linux/Mac**: `bin/linux-x86-64/sonar.sh start`

## Paso 2: Acceder a SonarQube

1. Abrir el navegador en: http://localhost:9000
2. Credenciales por defecto:
   - Usuario: `admin`
   - Contraseña: `admin`
3. Al iniciar sesión por primera vez, se pedirá cambiar la contraseña

## Paso 3: Configurar Token de Acceso

1. En SonarQube, ir a: **My Account** (arriba derecha)
2. Ir a la pestaña **Security**
3. Generar un nuevo token:
   - Nombre: `recetas-spring-token`
   - Tipo: `User Token`
   - Click en **Generate**
4. **Copiar el token generado** (solo se muestra una vez)

## Paso 4: Configurar el Proyecto

El proyecto ya está configurado con:
- `sonar-project.properties`: Configuración del proyecto
- `pom.xml`: Plugin de SonarQube agregado
- `scripts/sonar_scan.sh`: Script para ejecutar el análisis

### Verificar Configuración

El archivo `sonar-project.properties` contiene:
```properties
sonar.projectKey=recetas-spring
sonar.projectName=Recetas Spring Application
sonar.projectVersion=1.0
sonar.sources=src/main/java
sonar.tests=src/test/java
sonar.language=java
sonar.sourceEncoding=UTF-8
```

## Paso 5: Ejecutar Análisis

### Método 1: Usando el Script (Recomendado)

```bash
# Desde la raíz del proyecto
./scripts/sonar_scan.sh
```

**Nota:** Si el script pide contraseña, usar el token generado en el Paso 3.

### Método 2: Usando Maven Directamente

```bash
# Compilar el proyecto
mvn clean compile

# Ejecutar análisis de SonarQube
mvn sonar:sonar \
    -Dsonar.projectKey=recetas-spring \
    -Dsonar.host.url=http://localhost:9000 \
    -Dsonar.login=TU_TOKEN_AQUI
```

Reemplazar `TU_TOKEN_AQUI` con el token generado en el Paso 3.

### Método 3: Usando Variables de Entorno

```bash
export SONAR_TOKEN=tu_token_aqui
mvn sonar:sonar \
    -Dsonar.projectKey=recetas-spring \
    -Dsonar.host.url=http://localhost:9000 \
    -Dsonar.login=$SONAR_TOKEN
```

## Paso 6: Ver Resultados

1. Abrir el navegador en: http://localhost:9000
2. Iniciar sesión
3. Buscar el proyecto "Recetas Spring Application" o acceder directamente a:
   http://localhost:9000/dashboard?id=recetas-spring

## Paso 7: Capturar Evidencia

### Screenshots Necesarios:

1. **Dashboard Principal**
   - Captura de la página principal del proyecto
   - Mostrar métricas generales

2. **Vulnerabilidades**
   - Ir a la pestaña **Issues**
   - Filtrar por **Security Hotspots** y **Vulnerabilities**
   - Capturar lista de vulnerabilidades

3. **Vulnerabilidades Críticas**
   - Filtrar por severidad: **Critical** o **Blocker**
   - Capturar cada vulnerabilidad crítica encontrada
   - Capturar detalles de cada una

4. **Métricas de Calidad**
   - Capturar sección de métricas
   - Mostrar: Bugs, Vulnerabilities, Code Smells, Coverage

5. **Análisis Después de Correcciones**
   - Repetir capturas después de corregir vulnerabilidades
   - Mostrar comparación antes/después

## Paso 8: Clasificar Vulnerabilidades

En SonarQube, las vulnerabilidades se clasifican como:

- **Blocker**: Problemas críticos que deben corregirse inmediatamente
- **Critical**: Problemas importantes que deben corregirse pronto
- **Major**: Problemas significativos que deberían corregirse
- **Minor**: Problemas menores que pueden corregirse
- **Info**: Información adicional

### Cómo Clasificar:

1. Ir a **Issues** en el dashboard
2. Filtrar por tipo: **Vulnerability** o **Security Hotspot**
3. Agrupar por severidad
4. Documentar cada vulnerabilidad crítica:
   - Descripción del problema
   - Ubicación en el código
   - Impacto potencial
   - Alternativas de solución

## Paso 9: Corregir Vulnerabilidades Críticas

1. Revisar cada vulnerabilidad crítica
2. Leer la descripción y recomendación de SonarQube
3. Corregir el código
4. Documentar la corrección:
   - Código antes
   - Código después
   - Explicación de la corrección

## Paso 10: Re-ejecutar Análisis

Después de corregir las vulnerabilidades:

```bash
# Re-ejecutar análisis
./scripts/sonar_scan.sh
```

O:

```bash
mvn sonar:sonar \
    -Dsonar.projectKey=recetas-spring \
    -Dsonar.host.url=http://localhost:9000 \
    -Dsonar.login=TU_TOKEN
```

## Paso 11: Verificar Correcciones

1. Volver al dashboard de SonarQube
2. Verificar que las vulnerabilidades críticas ya no aparecen
3. Comparar métricas antes/después
4. Capturar screenshots de la comparación

## Solución de Problemas

### SonarQube no inicia

- Verificar que el puerto 9000 esté disponible
- Revisar los logs: `docker logs sonarqube` (si usa Docker)
- Verificar que Java esté instalado y en el PATH

### Error de autenticación

- Verificar que el token sea correcto
- Generar un nuevo token si es necesario
- Verificar que SonarQube esté ejecutándose

### El análisis falla

- Verificar que el proyecto compile correctamente: `mvn clean compile`
- Revisar la configuración en `sonar-project.properties`
- Verificar que SonarQube esté ejecutándose
- Revisar logs de Maven para más detalles

### No se encuentran archivos

- Verificar rutas en `sonar-project.properties`
- Asegurarse de que `src/main/java` existe
- Verificar permisos de lectura

## Ejemplo de Comando Completo

```bash
# 1. Iniciar SonarQube (Docker)
docker run -d --name sonarqube -p 9000:9000 sonarqube:community

# 2. Esperar a que SonarQube esté listo (30-60 segundos)
sleep 60

# 3. Compilar proyecto
mvn clean compile

# 4. Ejecutar análisis
mvn sonar:sonar \
    -Dsonar.projectKey=recetas-spring \
    -Dsonar.host.url=http://localhost:9000 \
    -Dsonar.login=TU_TOKEN_AQUI

# 5. Ver resultados en: http://localhost:9000/dashboard?id=recetas-spring
```

## Recursos Adicionales

- Documentación oficial: https://docs.sonarqube.org/
- Reglas de calidad: https://rules.sonarsource.com/java
- Comunidad: https://community.sonarsource.com/
- Guía de integración Maven: https://docs.sonarqube.org/latest/analysis/scan/sonarscanner-for-maven/

