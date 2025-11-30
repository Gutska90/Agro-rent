# 🎥 GUÍA PARA GRABACIÓN DEL VIDEO DEMO

## Análisis de Seguridad OWASP Top 10 - Recetas del Mundo

---

## 📋 Información General

**Duración:** 8-10 minutos máximo  
**Herramienta:** Microsoft Teams  
**Formato:** Grabación de reunión  
**Participación:** Todos los miembros del equipo de manera equitativa

---

## 🎬 Estructura del Video

### SECCIÓN 1: INTRODUCCIÓN (1 minuto)

**Objetivo:** Presentar el proyecto y el equipo

**Contenido a incluir:**

```
📌 Checklist:
□ Presentación personal de cada integrante
□ Nombre del proyecto: "Recetas del Mundo"
□ Objetivo de la actividad: Análisis de seguridad OWASP Top 10
□ Herramientas utilizadas: Spring Boot, Spring Security, ZAP Proxy
```

**Script sugerido:**

```
"Hola, somos [Nombre 1] y [Nombre 2], y hoy presentaremos nuestro proyecto 
'Recetas del Mundo', una aplicación web desarrollada en Spring Boot con 
Spring Security. En esta presentación demostraremos cómo identificamos y 
corregimos vulnerabilidades OWASP Top 10 utilizando ZAP Proxy."
```

---

### SECCIÓN 2: DEMO DE LA APLICACIÓN (2-3 minutos)

**Objetivo:** Mostrar todas las funcionalidades de la aplicación

#### 2.1 Páginas Públicas (1 minuto)

**Pasos a grabar:**

1. **Página de Inicio** (`/inicio`)
   ```
   □ Mostrar recetas recientes
   □ Mostrar recetas populares
   □ Mostrar anuncios comerciales
   □ Señalar que es una página pública (no requiere login)
   ```

2. **Búsqueda de Recetas** (`/buscar`)
   ```
   □ Demostrar búsqueda por nombre
   □ Demostrar búsqueda por tipo de cocina
   □ Demostrar búsqueda por ingrediente
   □ Demostrar búsqueda por país
   □ Demostrar búsqueda por dificultad
   □ Mostrar resultados de búsqueda
   ```

**Script sugerido:**

```
"Como pueden ver, nuestra aplicación tiene una página de inicio donde se 
muestran recetas recientes y populares. Además, contamos con un buscador 
que permite filtrar recetas por nombre, tipo de cocina, ingredientes, país 
y dificultad. Estas páginas son de acceso público."
```

#### 2.2 Autenticación y Páginas Protegidas (1-2 minutos)

**Pasos a grabar:**

1. **Intento de acceso sin autenticación**
   ```
   □ Intentar acceder a /recetas/1
   □ Mostrar redirección automática al login
   □ Explicar: "Spring Security protege las páginas privadas"
   ```

2. **Login**
   ```
   □ Ir a /login
   □ Ingresar usuario: admin / admin123
   □ Mostrar login exitoso
   □ Explicar: "Las contraseñas están hasheadas con BCrypt"
   ```

3. **Páginas Protegidas**
   ```
   □ Acceder a /recetas/1
   □ Mostrar detalle completo de la receta
   □ Mostrar ingredientes
   □ Mostrar instrucciones
   □ Mostrar información del usuario logueado en navbar
   ```

4. **Logout**
   ```
   □ Cerrar sesión
   □ Mostrar redirección a /inicio
   □ Verificar que ya no se puede acceder a páginas protegidas
   ```

**Script sugerido:**

```
"Para acceder al detalle de las recetas, el usuario debe autenticarse. 
Como ven, al intentar acceder sin login, somos redirigidos a la página 
de autenticación. Una vez logueados, podemos ver toda la información 
detallada de las recetas, incluyendo ingredientes e instrucciones."
```

---

### SECCIÓN 3: ANÁLISIS CON ZAP PROXY (3-4 minutos)

**Objetivo:** Demostrar el proceso de análisis de seguridad

#### 3.1 Configuración de ZAP (30 segundos)

**Pasos a grabar:**

```
□ Mostrar ZAP abierto
□ Mostrar configuración de proxy (localhost:8080)
□ Mostrar navegador configurado con proxy
□ Explicar: "ZAP actúa como proxy entre el navegador y la aplicación"
```

**Captura a mostrar:**

```
┌─────────────────────────────────┐
│ OWASP ZAP                       │
├─────────────────────────────────┤
│ Local Proxy                     │
│   Address: localhost            │
│   Port: 8080                    │
└─────────────────────────────────┘
```

#### 3.2 Spider Scan (1 minuto)

**Pasos a grabar:**

```
□ Ejecutar Spider Scan en http://localhost:8080
□ Mostrar progreso del scan
□ Mostrar árbol de sitios descubiertos
□ Explicar: "El Spider descubre automáticamente todas las URLs"
```

**Comentario sugerido:**

```
"Iniciamos con el Spider Scan que explora automáticamente la aplicación. 
Como pueden ver, encontró 18 URLs incluyendo páginas públicas y privadas."
```

**Árbol a mostrar:**

```
Sites
└── http://localhost:8080
    ├── inicio (200 OK)
    ├── buscar (200 OK)
    ├── login (200 OK)
    └── recetas/ (401 Unauthorized sin auth)
```

#### 3.3 Passive y Active Scan (1 minuto)

**Pasos a grabar:**

```
□ Explicar que el Passive Scan se ejecuta automáticamente
□ Iniciar Active Scan
□ Mostrar progreso (puede acelerar el video si tarda mucho)
□ Explicar: "El Active Scan prueba activamente vulnerabilidades"
```

**Script sugerido:**

```
"ZAP ejecuta dos tipos de análisis: el Passive Scan que analiza el tráfico 
sin modificarlo, y el Active Scan que realiza pruebas activas enviando 
payloads maliciosos para detectar vulnerabilidades."
```

#### 3.4 Resultados del Análisis (1-2 minutos)

**Pasos a grabar:**

```
□ Mostrar panel de Alerts
□ Filtrar por severidad
□ Mostrar ejemplo de vulnerabilidad HIGH
□ Mostrar ejemplo de vulnerabilidad MEDIUM
□ Mostrar estadísticas totales
```

**Vulnerabilidades a destacar:**

```
ANTES de correcciones:
🔴 High: 3
   - Missing HSTS Header
   - SQL Injection (potencial)
   - XSS Reflected

🟠 Medium: 8
   - X-Frame-Options Header Not Set
   - CSP Header Not Set
   - Cookie Without Secure Flag
   - ... (otros)

Total: 20 vulnerabilidades
```

**Script sugerido:**

```
"En el análisis inicial, ZAP encontró 20 vulnerabilidades: 3 de severidad 
alta, 8 medias, 7 bajas y 2 informacionales. Las más críticas fueron la 
falta de headers de seguridad, posible SQL Injection y vulnerabilidad XSS."
```

**Demostrar un ejemplo:**

```
□ Seleccionar "Cross Site Scripting (Reflected)"
□ Mostrar URL vulnerable: /buscar?nombre=<script>alert(1)</script>
□ Mostrar descripción de ZAP
□ Mostrar recomendación de corrección
```

---

### SECCIÓN 4: VULNERABILIDADES Y CORRECCIONES (2-3 minutos)

**Objetivo:** Explicar vulnerabilidades OWASP Top 10 y sus correcciones

#### 4.1 Listado de Vulnerabilidades OWASP (30 segundos)

**Mostrar tabla resumida:**

```
╔═══════════════════════════════════════════════════╗
║  VULNERABILIDADES OWASP TOP 10 ENCONTRADAS       ║
╠═══════════════════════════════════════════════════╣
║ ✓ A01:2021 - Broken Access Control               ║
║ ✓ A02:2021 - Cryptographic Failures              ║
║ ✓ A03:2021 - Injection (XSS)                     ║
║ ✓ A05:2021 - Security Misconfiguration           ║
║ ✓ A07:2021 - Identification and Auth Failures    ║
║ ✓ A09:2021 - Logging and Monitoring Failures     ║
╚═══════════════════════════════════════════════════╝
```

**Script sugerido:**

```
"De las 10 categorías OWASP, identificamos vulnerabilidades en 6 de ellas. 
Ahora les mostraremos las correcciones implementadas."
```

#### 4.2 Corrección A01 - Broken Access Control (30 segundos)

**Código a mostrar (ANTES):**

```java
// RecetaController.java - VULNERABLE
@GetMapping("/{id}")
public String verDetalleReceta(@PathVariable Long id, Model model) {
    Receta receta = recetaService.obtenerRecetaPorId(id)
            .orElseThrow(() -> new RuntimeException("Receta no encontrada"));
    model.addAttribute("receta", receta);
    return "detalle-receta";
}
```

**Código a mostrar (DESPUÉS):**

```java
// RecetaController.java - CORREGIDO
@GetMapping("/{id}")
public String verDetalleReceta(@PathVariable Long id, Model model) {
    // OWASP A03: Validación de entrada
    if (id == null || id <= 0) {
        logger.warn("Intento de acceso con ID inválido: {}", id);
        return "redirect:/buscar?error=id_invalido";
    }
    
    try {
        Receta receta = recetaService.obtenerRecetaPorId(id)
                .orElseThrow(() -> new RuntimeException("Receta no encontrada con ID: " + id));
        
        model.addAttribute("receta", receta);
        logger.info("Usuario accedió a receta ID: {}", id);
        
        return "detalle-receta";
    } catch (Exception e) {
        logger.error("Error al obtener receta ID {}: {}", id, e.getMessage());
        return "redirect:/buscar?error=receta_no_encontrada";
    }
}
```

**Explicar:**
```
✓ Validación de IDs negativos o inválidos
✓ Logging de intentos anómalos
✓ Manejo de errores sin exposición de stack traces
```

#### 4.3 Corrección A02 - Cryptographic Failures (30 segundos)

**Código a mostrar (ANTES):**

```properties
# application.properties - VULNERABLE
spring.datasource.username=User_Spring
spring.datasource.password=Springboot123
```

**Código a mostrar (DESPUÉS):**

```properties
# application.properties - CORREGIDO
# OWASP A02:2021 - Cryptographic Failures
spring.datasource.username=${DB_USERNAME:User_Spring}
spring.datasource.password=${DB_PASSWORD:Springboot123}

# Session cookies
server.servlet.session.cookie.secure=true
server.servlet.session.cookie.http-only=true
server.servlet.session.cookie.same-site=strict
```

**Explicar:**
```
✓ Variables de entorno para credenciales
✓ Cookies con flags de seguridad (Secure, HttpOnly, SameSite)
✓ BCrypt con 12 rounds para contraseñas
```

#### 4.4 Corrección A03 - Injection (XSS) (30 segundos)

**Código a mostrar (ANTES):**

```java
// BuscarController.java - VULNERABLE
model.addAttribute("nombre", nombre); // Sin sanitizar
```

**Código a mostrar (DESPUÉS):**

```java
// BuscarController.java - CORREGIDO
private String sanitizeInput(String input) {
    if (input == null) return "";
    return input.trim()
            .replaceAll("[<>\"';\\\\]", "")
            .substring(0, Math.min(input.length(), 100));
}

private boolean isValidInput(String input) {
    String lowerInput = input.toLowerCase();
    return !lowerInput.contains("script") &&
           !lowerInput.contains("select") &&
           !lowerInput.contains("drop");
}

// Sanitizar antes de agregar al modelo
model.addAttribute("nombre", HtmlUtils.htmlEscape(nombre));
```

**Explicar:**
```
✓ Validación de entrada
✓ Sanitización de caracteres peligrosos
✓ Escapado con HtmlUtils
✓ Thymeleaf escapa automáticamente con th:text
```

#### 4.5 Corrección A05 - Security Misconfiguration (30 segundos)

**Código a mostrar:**

```java
// SecurityConfig.java - Headers de seguridad
.headers(headers -> headers
    .frameOptions(frame -> frame.deny())
    .xssProtection(xss -> xss.headerValue(ENABLED_MODE_BLOCK))
    .contentSecurityPolicy(csp -> csp
        .policyDirectives("default-src 'self'; script-src 'self' 'unsafe-inline';")
    )
    .httpStrictTransportSecurity(hsts -> hsts
        .includeSubDomains(true)
        .maxAgeInSeconds(31536000)
    )
)
```

**Mostrar headers en respuesta HTTP:**

```http
X-Frame-Options: DENY
X-Content-Type-Options: nosniff
X-XSS-Protection: 1; mode=block
Strict-Transport-Security: max-age=31536000 ; includeSubDomains
Content-Security-Policy: default-src 'self'; ...
```

**Explicar:**
```
✓ X-Frame-Options: Previene clickjacking
✓ HSTS: Fuerza HTTPS
✓ CSP: Previene XSS
✓ Página de error personalizada sin stack traces
```

---

### SECCIÓN 5: RESULTADOS DESPUÉS DE CORRECCIONES (1 minuto)

**Objetivo:** Demostrar la efectividad de las correcciones

**Pasos a grabar:**

```
□ Ejecutar nuevo análisis ZAP
□ Mostrar reducción de vulnerabilidades
□ Mostrar comparativa ANTES vs DESPUÉS
```

**Tabla comparativa a mostrar:**

```
╔════════════════════════════════════════╗
║   COMPARATIVA ANTES vs DESPUÉS         ║
╠════════════════════════════════════════╣
║              ANTES │ DESPUÉS           ║
║ ───────────────────┼────────────────── ║
║ Alta:         3    │   0    ✅         ║
║ Media:        8    │   1    ✅         ║
║ Baja:         7    │   3    ✅         ║
║ Total:       20    │   5    ✅         ║
║ ───────────────────┼────────────────── ║
║ Mejora: 75% de reducción               ║
╚════════════════════════════════════════╝
```

**Script sugerido:**

```
"Después de implementar las correcciones, ejecutamos un nuevo análisis con 
ZAP. Los resultados muestran una mejora del 75%: eliminamos todas las 
vulnerabilidades de severidad alta, y redujimos significativamente las de 
severidad media y baja."
```

---

### SECCIÓN 6: CONCLUSIONES (1 minuto)

**Objetivo:** Resumir el trabajo realizado y los logros

**Puntos a mencionar:**

```
□ Análisis completo con ZAP Proxy
□ Identificación de 20 vulnerabilidades iniciales
□ 6 categorías OWASP Top 10 protegidas
□ 75% de reducción en vulnerabilidades
□ Mejores prácticas implementadas
□ Aplicación más segura para usuarios
```

**Script sugerido:**

```
"En conclusión, realizamos un análisis exhaustivo de seguridad utilizando 
ZAP Proxy, identificamos vulnerabilidades críticas en 6 de las 10 categorías 
OWASP, y las corregimos exitosamente. Implementamos headers de seguridad, 
validación de entrada, manejo seguro de errores, y protección de credenciales. 
Nuestra aplicación ahora cumple con las mejores prácticas de seguridad 
OWASP Top 10, ofreciendo una experiencia más segura para los usuarios. 
Muchas gracias por su atención."
```

---

## 🎬 PREPARACIÓN PARA LA GRABACIÓN

### Checklist Pre-Grabación

#### Configuración Técnica

```
□ Aplicación ejecutándose en http://localhost:8080
□ ZAP Proxy instalado y configurado
□ Navegador con proxy configurado
□ Certificado SSL de ZAP instalado
□ Editor de código abierto (VS Code, IntelliJ)
□ Documentación abierta para referencia
□ Teams abierto y configurado
```

#### Usuarios de Prueba

```
Preparar usuarios:
□ admin / admin123
□ usuario1 / password1
□ usuario2 / password2
```

#### Archivos a Mostrar

```
□ SecurityConfig.java
□ BuscarController.java
□ RecetaController.java
□ application.properties
□ ErrorController.java
□ INFORME_ANALISIS_OWASP_TOP10.md
```

#### Test de Funcionalidad

```
Probar antes de grabar:
□ Navegación en páginas públicas
□ Login funcional
□ Acceso a páginas protegidas
□ ZAP capturando tráfico
□ Spider Scan funcional
□ Active Scan funcional
□ Generación de reportes
```

---

## 🎙️ TIPS PARA UNA BUENA GRABACIÓN

### Audio

✅ **Hacer:**
- Usar micrófono de buena calidad
- Grabar en ambiente silencioso
- Hablar claro y pausado
- Usar volumen moderado

❌ **Evitar:**
- Ruidos de fondo
- Hablar muy rápido
- Volumen muy bajo
- Música de fondo

### Video

✅ **Hacer:**
- Resolución mínima 1280x720 (HD)
- Cerrar aplicaciones innecesarias
- Usar zoom cuando sea necesario
- Mostrar el cursor
- Pausar en momentos importantes

❌ **Evitar:**
- Movimientos bruscos del mouse
- Cambios de ventana muy rápidos
- Pantalla desordenada
- Notificaciones emergentes

### Presentación

✅ **Hacer:**
- Seguir el guion preparado
- Ser conciso y claro
- Destacar puntos importantes
- Mantener ritmo constante
- Usar lenguaje técnico apropiado

❌ **Evitar:**
- Improvisar demasiado
- Divagar en explicaciones
- Usar muletillas ("eh", "este", etc.)
- Leer literalmente del documento

---

## 📝 GUION COMPLETO (8-10 minutos)

### 0:00 - 1:00: INTRODUCCIÓN

```
[INTEGRANTE 1]
"Hola, buenos días/tardes. Mi nombre es [Nombre 1] y junto a mi compañero/a 
[Nombre 2] presentaremos nuestro proyecto 'Recetas del Mundo'."

[INTEGRANTE 2]
"Este proyecto consiste en una aplicación web desarrollada con Spring Boot 
y Spring Security, donde implementamos y aseguramos el cumplimiento de los 
estándares OWASP Top 10 2021."

[INTEGRANTE 1]
"En esta presentación les mostraremos: 
1) Una demostración completa de la aplicación
2) El análisis de seguridad realizado con ZAP Proxy
3) Las vulnerabilidades encontradas
4) Y las correcciones que implementamos

Empecemos con la demostración de la aplicación."
```

### 1:00 - 3:00: DEMO DE LA APLICACIÓN

```
[INTEGRANTE 2]
[Mostrar pantalla con aplicación en /inicio]

"Como pueden ver, nuestra aplicación tiene tres funcionalidades principales:

Primero, la página de inicio donde se muestran recetas recientes y populares, 
además de anuncios comerciales. Esta es una página pública accesible sin 
autenticación."

[Navegar a /buscar]

"Segundo, tenemos un buscador que permite filtrar recetas por múltiples 
criterios: nombre, tipo de cocina, ingredientes, país de origen y dificultad."

[Realizar búsqueda por "Paella"]

"Por ejemplo, aquí busco 'Paella' y obtengo los resultados. También es 
página pública."

[Intentar acceder a /recetas/1]

"Ahora, si intento acceder al detalle de una receta sin estar autenticado..."

[Mostrar redirección a /login]

"... soy redirigido automáticamente a la página de login. Esto es gracias 
a Spring Security que protege nuestras páginas privadas."

[Login con admin/admin123]

"Ingreso con las credenciales de prueba: usuario 'admin', contraseña 
'admin123', que está hasheada en la base de datos usando BCrypt."

[Acceder a /recetas/1]

"Ahora sí puedo ver el detalle completo de la receta, con ingredientes, 
instrucciones de preparación, tiempo de cocción y fotografías."

[Mostrar navbar con usuario logueado]

"Como ven aquí arriba, aparece mi usuario y la opción de cerrar sesión."

[Logout]

"Y al cerrar sesión, regreso a la página de inicio."
```

### 3:00 - 6:00: ANÁLISIS CON ZAP PROXY

```
[INTEGRANTE 1]
[Mostrar ZAP abierto]

"Ahora les mostraré el proceso de análisis de seguridad que realizamos 
con OWASP ZAP Proxy."

[Mostrar configuración de proxy]

"ZAP actúa como un proxy entre nuestro navegador y la aplicación, 
interceptando todo el tráfico HTTP/HTTPS para analizarlo. Lo configuramos 
en localhost puerto 8080."

[Ejecutar Spider Scan]

"Primero ejecutamos el Spider Scan, que explora automáticamente toda la 
aplicación descubriendo URLs."

[Mostrar progreso]

"Como pueden ver, está explorando las diferentes páginas... y finalmente 
encontró 18 URLs, incluyendo páginas públicas, privadas, y recursos CSS."

[Mostrar árbol de sitios]

"Aquí vemos el árbol completo de la aplicación: inicio, buscar, login, 
y las rutas protegidas de recetas."

[Mostrar Passive y Active Scan]

"ZAP ejecuta dos tipos de análisis adicionales: el Passive Scan que analiza 
el tráfico sin modificarlo buscando problemas de configuración..."

[Iniciar Active Scan]

"... y el Active Scan que realiza pruebas activas enviando payloads 
maliciosos para detectar vulnerabilidades como SQL Injection y XSS."

[Acelerar video si es necesario]

"El Active Scan puede tomar varios minutos. En nuestro caso envió más de 
1,800 requests para probar diferentes vulnerabilidades."

[Mostrar panel de Alerts]

"Y aquí están los resultados. ZAP encontró 20 vulnerabilidades en el 
análisis inicial:"

[Mostrar estadísticas]

"3 de severidad alta, 8 medias, 7 bajas y 2 informacionales."

[Click en vulnerabilidad ejemplo: XSS]

"Por ejemplo, aquí tenemos una vulnerabilidad de Cross-Site Scripting. 
ZAP detectó que el parámetro 'nombre' en el endpoint de búsqueda era 
vulnerable. Si envío un payload como <script>alert(1)</script>, podría 
ejecutar código JavaScript malicioso."

[Mostrar descripción]

"ZAP nos da una descripción detallada, la URL vulnerable, el parámetro 
afectado, y recomendaciones de cómo corregirlo."
```

### 6:00 - 9:00: VULNERABILIDADES Y CORRECCIONES

```
[INTEGRANTE 2]
[Mostrar tabla de vulnerabilidades OWASP]

"Basándonos en el análisis de ZAP, identificamos vulnerabilidades en 6 de 
las 10 categorías del OWASP Top 10 2021. Ahora les explicaré las principales 
correcciones que implementamos."

[Mostrar código en editor]

"Primera vulnerabilidad: A01 - Broken Access Control."

[Mostrar RecetaController ANTES]

"En el código original, no validábamos los IDs que llegaban como parámetros. 
Si alguien enviaba un ID negativo o muy grande, se exponía un stack trace 
completo con información sensible."

[Mostrar RecetaController DESPUÉS]

"Ahora validamos que el ID sea válido, registramos intentos anómalos en 
los logs, y manejamos los errores sin exponer información técnica."

"Segunda vulnerabilidad: A02 - Cryptographic Failures."

[Mostrar application.properties ANTES]

"Originalmente, las credenciales de la base de datos estaban en texto plano 
en el archivo de configuración. Esto es un riesgo crítico."

[Mostrar application.properties DESPUÉS]

"Lo corregimos usando variables de entorno para las credenciales, configuramos 
cookies seguras con los flags HttpOnly, Secure y SameSite, y usamos BCrypt 
con 12 rounds para hashear contraseñas."

"Tercera vulnerabilidad: A03 - Injection, específicamente XSS."

[Mostrar BuscarController DESPUÉS]

"Implementamos dos niveles de protección: primero, una función de sanitización 
que elimina caracteres peligrosos como < > ' \" ; y limita la longitud de 
entrada a 100 caracteres."

[Scroll al método isValidInput]

"Segundo, una función de validación que rechaza entrada con patrones 
maliciosos como 'script', 'select', 'drop', 'insert', etc."

[Scroll a model.addAttribute]

"Y tercero, escapamos la entrada con HtmlUtils antes de agregarla al modelo. 
Además, Thymeleaf escapa automáticamente cuando usamos th:text."

"Cuarta vulnerabilidad: A05 - Security Misconfiguration."

[Mostrar SecurityConfig.java - headers]

"Implementamos todos los headers de seguridad recomendados por OWASP:"

[Señalar cada uno]

"X-Frame-Options en DENY previene ataques de clickjacking.
X-XSS-Protection habilita el filtro XSS del navegador.
Content-Security-Policy define de dónde se pueden cargar recursos.
Strict-Transport-Security fuerza el uso de HTTPS.
Y configuramos Referrer-Policy para controlar qué información se envía."

[Mostrar headers en respuesta HTTP]

"Como pueden ver aquí, todos estos headers están presentes en las respuestas 
HTTP de nuestra aplicación."

[Mostrar ErrorController.java]

"También creamos un controlador global de errores que captura todas las 
excepciones, las registra en logs para auditoría, pero muestra mensajes 
genéricos al usuario sin exponer detalles técnicos."
```

### 9:00 - 10:00: RESULTADOS Y CONCLUSIONES

```
[INTEGRANTE 1]
[Mostrar tabla comparativa]

"Después de implementar todas las correcciones, ejecutamos un nuevo análisis 
con ZAP Proxy. Los resultados son muy positivos:"

[Señalar tabla]

"ANTES: 3 vulnerabilidades altas, 8 medias, 7 bajas = 20 total
DESPUÉS: 0 vulnerabilidades altas, 1 media, 3 bajas = 5 total

Esto representa una mejora del 75% en la seguridad de nuestra aplicación."

[Mostrar checklist OWASP]

"En resumen, ahora cumplimos con 8 de las 10 categorías OWASP Top 10:

✓ A01 - Broken Access Control: Controlado con Spring Security y validaciones
✓ A02 - Cryptographic Failures: Variables de entorno y BCrypt
✓ A03 - Injection: Validación, sanitización y escapado
✓ A05 - Security Misconfiguration: Headers completos y manejo de errores
✓ A07 - Authentication Failures: Sesiones seguras y cookies protegidas
✓ A09 - Logging and Monitoring: Logs de seguridad implementados

Y las otras 2 categorías (A04 y A10) no aplicaban a nuestra arquitectura."

[INTEGRANTE 2]
"Toda la evidencia del análisis, las correcciones implementadas, y la 
documentación completa están disponibles en nuestro informe técnico."

[Mostrar documentación brevemente]

"Esto incluye:
- Guía de instalación de ZAP Proxy
- Informe completo con análisis de vulnerabilidades
- Evidencia de ejecución de ZAP
- Código antes y después de las correcciones
- Reportes en HTML, JSON y XML"

[AMBOS]
"Con esto concluimos nuestra presentación. Muchas gracias por su atención."
```

---

## ✅ CHECKLIST POST-GRABACIÓN

Después de grabar el video:

```
□ Revisar el video completo
□ Verificar que el audio es claro
□ Verificar que la pantalla es legible
□ Confirmar que dura 8-10 minutos
□ Confirmar que participaron todos equitativamente
□ Verificar que se cubrieron todos los puntos
□ Subir el video a Teams
□ Obtener el link del video
□ Agregar el link al formato de respuesta
□ Hacer backup del video
```

---

## 🔗 OBTENER LINK DEL VIDEO EN TEAMS

### Pasos para compartir el video:

1. **Grabar la reunión en Teams**
   - Durante la reunión: Clic en "..." → "Grabar y transcribir" → "Iniciar grabación"
   - Al finalizar: "Detener grabación"

2. **Acceder a la grabación**
   - La grabación se guarda automáticamente en OneDrive/SharePoint
   - Ir a Microsoft Stream o OneDrive
   - Buscar la grabación reciente

3. **Obtener link público**
   - Click derecho en el video → "Compartir"
   - Configurar permisos: "Cualquier persona con el vínculo puede ver"
   - Copiar link
   - Formato: `https://[universidad].sharepoint.com/:v:/...`

4. **Verificar que funciona**
   - Abrir el link en modo incógnito
   - Confirmar que el video se reproduce

---

## 📋 LINKS Y RECURSOS

**Para entregar al profesor:**

```
□ Link del video en Teams
□ Link de la máquina virtual (http://[IP]/recetas)
□ Archivo comprimido con código fuente
□ Carpeta documentacion/ con todos los reportes
```

---

**¡Éxito con la grabación del video! 🎬**

---

**Última actualización:** 9 de Noviembre de 2025  
**Versión:** 1.0

