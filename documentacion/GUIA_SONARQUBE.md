# Guía de Configuración y Uso de SonarQube

## Requisitos Previos

- Java 17 o superior
- Maven 3.6 o superior
- Docker (opcional, para ejecutar SonarQube en contenedor)

## Instalación de SonarQube

### Opción 1: Usando Docker (Recomendado)

```bash
# Ejecutar SonarQube en un contenedor Docker
docker run -d --name sonarqube -p 9000:9000 sonarqube:community

# Verificar que está ejecutándose
curl http://localhost:9000/api/system/status
```

### Opción 2: Instalación Local

1. Descargar SonarQube Community Edition desde: https://www.sonarqube.org/downloads/
2. Extraer el archivo descargado
3. Ejecutar SonarQube:
   - **Windows**: `bin\windows-x86-64\StartSonar.bat`
   - **Linux/Mac**: `bin/linux-x86-64/sonar.sh start`

## Acceso a SonarQube

1. Abrir el navegador en: http://localhost:9000
2. Credenciales por defecto:
   - Usuario: `admin`
   - Contraseña: `admin`
3. Al iniciar sesión por primera vez, se pedirá cambiar la contraseña

## Configuración del Proyecto

El proyecto ya está configurado con:
- `sonar-project.properties`: Configuración del proyecto
- `pom.xml`: Plugin de SonarQube agregado
- `scripts/sonar_scan.sh`: Script para ejecutar el análisis

## Ejecutar Análisis de SonarQube

### Método 1: Usando el Script (Recomendado)

```bash
# Desde la raíz del proyecto
./scripts/sonar_scan.sh
```

### Método 2: Usando Maven Directamente

```bash
# Compilar el proyecto
mvn clean compile

# Ejecutar análisis de SonarQube
mvn sonar:sonar \
    -Dsonar.projectKey=recetas-spring \
    -Dsonar.host.url=http://localhost:9000 \
    -Dsonar.login=admin \
    -Dsonar.password=admin
```

## Ver Resultados

1. Abrir el navegador en: http://localhost:9000
2. Iniciar sesión con las credenciales configuradas
3. Buscar el proyecto "Recetas Spring Application" o acceder directamente a:
   http://localhost:9000/dashboard?id=recetas-spring

## Interpretación de Resultados

### Tipos de Issues

- **Blocker**: Problemas críticos que deben corregirse inmediatamente
- **Critical**: Problemas importantes que deben corregirse pronto
- **Major**: Problemas significativos que deberían corregirse
- **Minor**: Problemas menores que pueden corregirse
- **Info**: Información adicional

### Métricas Principales

- **Code Smells**: Problemas de mantenibilidad del código
- **Bugs**: Errores en el código
- **Vulnerabilities**: Vulnerabilidades de seguridad
- **Coverage**: Cobertura de pruebas (si está configurada)
- **Duplications**: Código duplicado

## Corregir Vulnerabilidades Críticas

1. Revisar la lista de vulnerabilidades en SonarQube
2. Priorizar las marcadas como "Critical" o "Blocker"
3. Corregir el código según las recomendaciones
4. Ejecutar el análisis nuevamente para verificar las correcciones

## Configuración Avanzada

### Personalizar Reglas

1. En SonarQube, ir a: **Quality Profiles**
2. Crear un perfil personalizado o modificar el existente
3. Activar/desactivar reglas según necesidades

### Integración con CI/CD

El análisis puede integrarse en pipelines de CI/CD:

```yaml
# Ejemplo para GitHub Actions
- name: SonarQube Scan
  uses: sonarsource/sonarqube-scan-action@master
  env:
    SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
    SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
```

## Solución de Problemas

### SonarQube no inicia

- Verificar que el puerto 9000 esté disponible
- Revisar los logs: `docker logs sonarqube` (si usa Docker)

### Error de autenticación

- Verificar credenciales en SonarQube
- Generar un token en: **My Account > Security > Generate Token**

### El análisis falla

- Verificar que el proyecto compile correctamente
- Revisar la configuración en `sonar-project.properties`
- Verificar que SonarQube esté ejecutándose

## Recursos Adicionales

- Documentación oficial: https://docs.sonarqube.org/
- Reglas de calidad: https://rules.sonarsource.com/java
- Comunidad: https://community.sonarsource.com/

