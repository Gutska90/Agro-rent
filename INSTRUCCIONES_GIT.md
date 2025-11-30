# Instrucciones para Subir a Git

## ✅ Archivo Comprimido Creado

El archivo `Recetas-Spring-Semana6.zip` (168 KB) ha sido creado exitosamente y está listo para subir.

## 📤 Subir a Git

El archivo ya está agregado al commit. Para subirlo al repositorio remoto:

### Opción 1: Push Manual (Recomendado)

```bash
# Verificar que el archivo está en el commit
git status

# Hacer push (puede requerir autenticación)
git push origin master

# O si tu rama se llama main:
git push origin main
```

### Opción 2: Si hay problemas de permisos

Si recibes un error 403 (permisos denegados):

1. **Verificar credenciales:**
   ```bash
   git config --global user.name "Tu Nombre"
   git config --global user.email "tu@email.com"
   ```

2. **Usar token de acceso personal:**
   - Ir a GitHub → Settings → Developer settings → Personal access tokens
   - Crear un token con permisos `repo`
   - Usar el token como contraseña al hacer push

3. **O usar SSH:**
   ```bash
   # Cambiar remote a SSH
   git remote set-url origin git@github.com:BorisConcha/Recetas-Spring.git
   git push origin master
   ```

## 📋 Verificación

Después del push, verificar en GitHub:
- El archivo `Recetas-Spring-Semana6.zip` debe aparecer en el repositorio
- Tamaño: ~168 KB
- Ubicación: raíz del repositorio

## 📦 Contenido del Archivo Comprimido

El archivo incluye:
- ✅ Código fuente completo (frontend y backend)
- ✅ Scripts de base de datos
- ✅ Scripts de despliegue
- ✅ Documentación técnica
- ✅ Archivos de configuración
- ❌ Excluye: target/, .git/, archivos temporales

## 🔍 Verificar Contenido

```bash
# Ver contenido del zip
unzip -l Recetas-Spring-Semana6.zip | head -20

# Ver tamaño
ls -lh Recetas-Spring-Semana6.zip
```

## ⚠️ Nota

El archivo .zip está normalmente en .gitignore, pero se agregó con `-f` (force) porque es necesario para la entrega.

