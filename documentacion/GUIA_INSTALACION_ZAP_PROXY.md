# 📘 GUÍA DE INSTALACIÓN Y CONFIGURACIÓN DE ZAP PROXY

## Actividad: Análisis de Seguridad OWASP Top 10
**Asignatura:** Seguridad de Aplicaciones Web  
**Proyecto:** Recetas del Mundo

---

## 📋 Tabla de Contenidos

1. [Introducción a ZAP Proxy](#introducción-a-zap-proxy)
2. [Requisitos Previos](#requisitos-previos)
3. [Instalación de ZAP Proxy](#instalación-de-zap-proxy)
4. [Configuración Inicial](#configuración-inicial)
5. [Configuración del Navegador](#configuración-del-navegador)
6. [Ejecución de Análisis](#ejecución-de-análisis)
7. [Interpretación de Resultados](#interpretación-de-resultados)

---

## 1. Introducción a ZAP Proxy

### ¿Qué es ZAP Proxy?

**OWASP ZAP** (Zed Attack Proxy) es una herramienta de seguridad **gratuita y de código abierto** desarrollada por OWASP (Open Web Application Security Project) para realizar pruebas de penetración en aplicaciones web.

### Características Principales

- ✅ **Detección automática de vulnerabilidades** OWASP Top 10
- ✅ **Proxy interceptor** para análisis de tráfico HTTP/HTTPS
- ✅ **Spider automático** para descubrimiento de páginas
- ✅ **Scanner activo y pasivo** de vulnerabilidades
- ✅ **Interfaz gráfica intuitiva**
- ✅ **Soporte para API REST**
- ✅ **Generación de reportes detallados**

### Vulnerabilidades OWASP Top 10 que detecta

ZAP Proxy puede identificar las siguientes vulnerabilidades:

1. **A01:2021 - Broken Access Control**
2. **A02:2021 - Cryptographic Failures**
3. **A03:2021 - Injection** (SQL, XSS, Command Injection)
4. **A04:2021 - Insecure Design**
5. **A05:2021 - Security Misconfiguration**
6. **A06:2021 - Vulnerable and Outdated Components**
7. **A07:2021 - Identification and Authentication Failures**
8. **A08:2021 - Software and Data Integrity Failures**
9. **A09:2021 - Security Logging and Monitoring Failures**
10. **A10:2021 - Server-Side Request Forgery (SSRF)**

---

## 2. Requisitos Previos

### Hardware
- **RAM:** Mínimo 4 GB (Recomendado 8 GB)
- **Disco:** 500 MB de espacio libre
- **Procesador:** Dual-core o superior

### Software
- **Java:** JDK 11 o superior (ZAP requiere Java para ejecutarse)
- **Sistema Operativo:** Windows, macOS, o Linux
- **Navegador Web:** Chrome, Firefox, o Edge

### Verificar instalación de Java

```bash
# Verificar versión de Java
java -version

# Debería mostrar algo como:
# java version "17.0.x" o superior
```

Si Java no está instalado:
- **Windows/macOS:** Descargar de [java.com](https://www.java.com/es/download/)
- **Linux (Ubuntu/Debian):**
  ```bash
  sudo apt update
  sudo apt install openjdk-17-jdk
  ```

---

## 3. Instalación de ZAP Proxy

### Opción 1: Instalación desde el sitio oficial (Recomendada)

#### Paso 1: Descargar ZAP Proxy

1. Visitar el sitio oficial: [https://www.zaproxy.org/download/](https://www.zaproxy.org/download/)
2. Seleccionar la versión para tu sistema operativo:
   - **Windows:** `ZAP_2_15_0_windows.exe` (o versión más reciente)
   - **macOS:** `ZAP_2_15_0.dmg`
   - **Linux:** `ZAP_2_15_0_Linux.tar.gz`

#### Paso 2: Instalar en Windows

```powershell
# Ejecutar el instalador descargado
.\ZAP_2_15_0_windows.exe

# Seguir el asistente de instalación:
# 1. Aceptar licencia
# 2. Seleccionar directorio de instalación (por defecto: C:\Program Files\OWASP\Zed Attack Proxy)
# 3. Crear acceso directo en escritorio
# 4. Finalizar instalación
```

#### Paso 3: Instalar en macOS

```bash
# Abrir el archivo .dmg descargado
# Arrastrar ZAP a la carpeta Aplicaciones
# Ejecutar desde Launchpad o Aplicaciones
```

#### Paso 4: Instalar en Linux

```bash
# Extraer el archivo descargado
cd ~/Downloads
tar -xvf ZAP_2_15_0_Linux.tar.gz

# Mover a /opt
sudo mv ZAP_2.15.0 /opt/zaproxy

# Crear enlace simbólico
sudo ln -s /opt/zaproxy/zap.sh /usr/local/bin/zap

# Ejecutar ZAP
zap
```

### Opción 2: Instalación usando Docker

```bash
# Descargar imagen de ZAP
docker pull zaproxy/zap-stable

# Ejecutar ZAP en modo gráfico (requiere X11)
docker run -u zap -p 8080:8080 -p 8090:8090 -i zaproxy/zap-stable zap-webswing.sh

# Acceder desde el navegador
# http://localhost:8080/zap
```

---

## 4. Configuración Inicial

### Primer inicio de ZAP

1. **Ejecutar ZAP Proxy**
   - Windows: Buscar "ZAP" en el menú inicio
   - macOS: Abrir desde Aplicaciones
   - Linux: Ejecutar `zap` desde terminal

2. **Pantalla de Bienvenida**
   
   Al iniciar ZAP por primera vez, aparecerá un diálogo:
   
   ```
   ┌─────────────────────────────────────┐
   │  Do you want to persist the ZAP     │
   │  session?                            │
   │                                      │
   │  ○ No, I do not want to persist     │
   │  ● Yes, I want to persist           │
   └─────────────────────────────────────┘
   ```
   
   - Seleccionar: **"Yes, I want to persist this session"**
   - Elegir ubicación para guardar sesiones

3. **Configurar Proxy Local**

   ZAP configurará automáticamente un proxy en:
   - **Host:** localhost (127.0.0.1)
   - **Puerto:** 8080

### Configuración de Red

```
Menú: Tools → Options → Local Proxies

Configuración recomendada:
┌────────────────────────────────────┐
│ Address: localhost                 │
│ Port: 8080                         │
│ Behind NAT: ☐                      │
│ Remove Unsupported Encodings: ☑    │
│ Security → Unsafe SSL renegotiation│
│   Allow: ☑                         │
└────────────────────────────────────┘
```

### Configurar Certificado SSL

Para interceptar tráfico HTTPS:

1. Ir a: **Tools → Options → Dynamic SSL Certificates**
2. Clic en **"Generate"** o usar el certificado existente
3. **Guardar certificado:** Clic en "Save"
4. Guardar como: `zap_root_ca.cer`

---

## 5. Configuración del Navegador

### Opción A: Firefox (Recomendado para ZAP)

#### Paso 1: Configurar Proxy

1. Abrir Firefox
2. Ir a: **☰ → Settings → General**
3. Scroll hasta **"Network Settings"**
4. Clic en **"Settings..."**
5. Configurar:

```
Manual proxy configuration:
┌──────────────────────────────┐
│ HTTP Proxy: localhost        │
│ Port: 8080                   │
│ ☑ Also use this proxy for   │
│   HTTPS                      │
│                              │
│ No Proxy for: [vacío]       │
└──────────────────────────────┘
```

6. Clic en **OK**

#### Paso 2: Instalar Certificado ZAP

1. Ir a: **☰ → Settings → Privacy & Security**
2. Scroll hasta **"Certificates"**
3. Clic en **"View Certificates..."**
4. Pestaña **"Authorities"**
5. Clic en **"Import..."**
6. Seleccionar el archivo `zap_root_ca.cer`
7. Marcar: ☑ **"Trust this CA to identify websites"**
8. Clic en **OK**

### Opción B: Google Chrome

#### Configurar Proxy en Chrome

**Windows:**
```powershell
# Ejecutar Chrome con proxy
chrome.exe --proxy-server=localhost:8080
```

**macOS/Linux:**
```bash
# Ejecutar Chrome con proxy
google-chrome --proxy-server=localhost:8080
```

#### Instalar Certificado en Chrome

**Windows:**
1. Ir a: **⋮ → Settings → Privacy and security → Security**
2. Clic en **"Manage certificates"**
3. Pestaña **"Trusted Root Certification Authorities"**
4. Clic en **"Import..."**
5. Seleccionar `zap_root_ca.cer`
6. Seguir asistente

**macOS:**
1. Abrir **Keychain Access**
2. Arrastrar `zap_root_ca.cer` a **"System"**
3. Doble clic en el certificado
4. Expandir **"Trust"**
5. Seleccionar **"Always Trust"**

---

## 6. Ejecución de Análisis

### Análisis Automático (Automated Scan)

#### Paso 1: Configurar Target

1. En ZAP, ir a la pestaña **"Quick Start"**
2. En el campo **"URL to attack"**, ingresar:
   ```
   http://localhost:8080/inicio
   ```
3. Seleccionar: **"Attack"**

#### Paso 2: Spider (Descubrimiento de URLs)

El Spider explorará automáticamente:
```
┌───────────────────────────────┐
│ Spider Progress:              │
│ ████████████████░░░░ 80%      │
│                               │
│ URLs Found: 15                │
│ Duration: 1m 23s              │
└───────────────────────────────┘
```

#### Paso 3: Active Scan (Escaneo de Vulnerabilidades)

```
┌────────────────────────────────┐
│ Active Scan Progress:          │
│ ██████████████░░░░░░ 70%       │
│                                │
│ Requests: 1,250 / 1,780        │
│ Alerts: 12                     │
│ Duration: 5m 42s               │
└────────────────────────────────┘
```

### Análisis Manual

#### Paso 1: Exploración Manual

1. Con ZAP ejecutándose y navegador configurado
2. Navegar manualmente por la aplicación:
   - `/inicio`
   - `/buscar`
   - `/login` → iniciar sesión
   - `/recetas/1` (páginas protegidas)

#### Paso 2: Revisar Historial

```
En ZAP:
Sites
└── http://localhost:8080
    ├── GET:inicio (200 OK)
    ├── GET:buscar (200 OK)
    ├── GET:login (200 OK)
    ├── POST:login (302 Found)
    └── GET:recetas
        └── GET:1 (200 OK)
```

#### Paso 3: Passive Scan

ZAP analiza automáticamente cada petición:
- Headers de seguridad faltantes
- Cookies inseguras
- Exposición de información sensible

#### Paso 4: Active Scan en URLs específicas

1. Click derecho en un nodo del árbol de Sites
2. Seleccionar: **"Attack → Active Scan"**
3. Configurar:

```
┌────────────────────────────────────┐
│ Active Scan Policy:                │
│ ● Default Policy                   │
│ ○ Custom Policy                    │
│                                    │
│ Scope:                             │
│ ☑ Recurse                          │
│ ☑ Show advanced options            │
│                                    │
│ Technology:                        │
│ ☑ Spring Framework                 │
│ ☑ Java/JSP                         │
│ ☑ MySQL/Oracle                     │
└────────────────────────────────────┘
```

---

## 7. Interpretación de Resultados

### Panel de Alertas

Las vulnerabilidades se clasifican por severidad:

```
🔴 High (Alta)      - Críticas, requieren atención inmediata
🟠 Medium (Media)   - Importantes, deben corregirse
🟡 Low (Baja)       - Mejoras recomendadas
🔵 Informational    - Información adicional
```

### Ejemplo de Alertas Comunes

#### 1. Missing Anti-clickjacking Header
```
Risk: Medium
Confidence: Medium
URL: http://localhost:8080/inicio
Description: The response does not include either Content-Security-Policy 
             with 'frame-ancestors' directive or X-Frame-Options

OWASP: A05:2021 - Security Misconfiguration
```

#### 2. SQL Injection
```
Risk: High
Confidence: High
URL: http://localhost:8080/buscar?nombre=test' OR '1'='1
Description: SQL injection may be possible

OWASP: A03:2021 - Injection
```

#### 3. Cross Site Scripting (XSS)
```
Risk: High
Confidence: Medium
URL: http://localhost:8080/buscar?nombre=<script>alert(1)</script>
Description: User input is not properly sanitized

OWASP: A03:2021 - Injection
```

### Exportar Resultados

#### HTML Report

```
Menú: Report → Generate HTML Report

Opciones:
- Include details: ☑
- Include request/response: ☑
- Include screenshots: ☑

Guardar como: zap_report_recetas.html
```

#### JSON Report

```
Menú: Report → Export Report

Format: JSON
File: zap_report_recetas.json
```

#### XML Report

```
Menú: Report → Export Report

Format: XML
File: zap_report_recetas.xml
```

---

## 8. Comandos Útiles

### Ejecutar ZAP desde línea de comandos

```bash
# Scan básico
zap.sh -cmd -quickurl http://localhost:8080 -quickout report.html

# Scan con autenticación
zap.sh -cmd -quickurl http://localhost:8080 \
  -config api.key=your-api-key \
  -quickout report.html

# Modo daemon (para CI/CD)
zap.sh -daemon -port 8090 -config api.disablekey=true
```

### API de ZAP

```bash
# Iniciar Spider
curl "http://localhost:8090/JSON/spider/action/scan/?url=http://localhost:8080"

# Iniciar Active Scan
curl "http://localhost:8090/JSON/ascan/action/scan/?url=http://localhost:8080"

# Obtener alertas
curl "http://localhost:8090/JSON/core/view/alerts/"

# Generar reporte
curl "http://localhost:8090/OTHER/core/other/htmlreport/" > report.html
```

---

## 9. Troubleshooting

### Problema: ZAP no inicia

**Solución:**
```bash
# Verificar Java
java -version

# Si es necesario, establecer JAVA_HOME
export JAVA_HOME=/usr/lib/jvm/java-17-openjdk
export PATH=$JAVA_HOME/bin:$PATH
```

### Problema: Navegador no conecta con proxy

**Solución:**
1. Verificar que ZAP esté ejecutándose
2. Comprobar configuración de proxy en navegador
3. Verificar que el puerto 8080 no esté en uso:
   ```bash
   # Windows
   netstat -ano | findstr :8080
   
   # Linux/macOS
   lsof -i :8080
   ```

### Problema: Certificado SSL no válido

**Solución:**
1. Regenerar certificado en ZAP
2. Reinstalar certificado en navegador
3. Reiniciar navegador

---

## 10. Mejores Prácticas

### ✅ Antes del Análisis

- [ ] Realizar backup de la base de datos
- [ ] Ejecutar en entorno de pruebas, NO en producción
- [ ] Informar al equipo sobre el análisis
- [ ] Revisar logs del servidor durante el scan

### ✅ Durante el Análisis

- [ ] Monitorear recursos del sistema
- [ ] Guardar sesión regularmente
- [ ] Tomar capturas de pantalla de hallazgos críticos
- [ ] Documentar pasos de reproducción

### ✅ Después del Análisis

- [ ] Generar reporte completo
- [ ] Clasificar vulnerabilidades por prioridad
- [ ] Crear plan de remediación
- [ ] Re-escanear después de correcciones

---

## 11. Recursos Adicionales

### Documentación Oficial
- **ZAP Proxy:** https://www.zaproxy.org/docs/
- **OWASP Top 10:** https://owasp.org/www-project-top-ten/

### Tutoriales
- ZAP Getting Started: https://www.zaproxy.org/getting-started/
- ZAP Automation: https://www.zaproxy.org/docs/automate/

### Comunidad
- Forum ZAP: https://groups.google.com/g/zaproxy-users
- GitHub: https://github.com/zaproxy/zaproxy

---

## 📝 Conclusión

ZAP Proxy es una herramienta esencial para identificar vulnerabilidades OWASP Top 10 en aplicaciones web. Este tutorial proporciona los pasos necesarios para instalar, configurar y ejecutar análisis de seguridad en la aplicación **Recetas del Mundo**.

**Próximos pasos:**
1. Ejecutar análisis completo
2. Documentar vulnerabilidades encontradas
3. Implementar correcciones
4. Re-escanear para verificar soluciones

---

**Autor:** Equipo de Desarrollo  
**Fecha:** Noviembre 2025  
**Versión:** 1.0

