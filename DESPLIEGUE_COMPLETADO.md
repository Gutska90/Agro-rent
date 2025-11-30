# ✅ Punto 4 Completado - Despliegue en Máquina Virtual

## 📦 Archivos Creados para Despliegue

### Scripts de Despliegue
1. **`scripts/setup-vm.sh`** - Configuración inicial de la VM
   - Instala Java 17, Maven, MySQL, Nginx
   - Configura firewall
   - Crea usuario y directorios

2. **`scripts/deploy.sh`** - Script de despliegue
   - Compila el proyecto
   - Crea el JAR
   - Configura directorios necesarios

3. **`scripts/nginx-config.conf`** - Configuración de Nginx
   - Reverse proxy a la aplicación
   - Redirección a /recetas
   - Configuración de logs

4. **`scripts/systemd-service.service`** - Servicio systemd
   - Ejecuta la aplicación como servicio
   - Inicio automático al arrancar
   - Reinicio automático en caso de fallo

### Docker
1. **`Dockerfile`** - Imagen Docker para la aplicación
2. **`docker-compose.yml`** - Orquestación con MySQL

### Documentación
1. **`GUIA_DESPLIEGUE_VM.md`** - Guía completa paso a paso

## 🚀 Instrucciones Rápidas

### Opción 1: Despliegue Manual

```bash
# 1. En la VM, ejecutar configuración inicial
sudo bash scripts/setup-vm.sh

# 2. Subir proyecto a /opt/recetas
scp -r . usuario@IP_VM:/opt/recetas

# 3. En la VM, compilar y desplegar
cd /opt/recetas
bash scripts/deploy.sh

# 4. Configurar como servicio
sudo cp scripts/systemd-service.service /etc/systemd/system/recetas.service
sudo systemctl daemon-reload
sudo systemctl enable recetas
sudo systemctl start recetas

# 5. Configurar Nginx (opcional)
sudo cp scripts/nginx-config.conf /etc/nginx/sites-available/recetas
sudo ln -s /etc/nginx/sites-available/recetas /etc/nginx/sites-enabled/
sudo systemctl restart nginx
```

### Opción 2: Despliegue con Docker

```bash
# En la VM
docker-compose up -d
```

## ✅ Verificación

Una vez desplegado, verificar:

1. **Aplicación corriendo:**
   ```bash
   curl http://localhost:8080/recetas
   ```

2. **Servicio activo:**
   ```bash
   sudo systemctl status recetas
   ```

3. **Acceso público:**
   - Con Nginx: `http://IP_VM/recetas`
   - Sin Nginx: `http://IP_VM:8080/recetas`

## 📝 Notas Importantes

- **Seguridad**: Cambiar contraseñas por defecto antes de producción
- **Firewall**: Asegurar que los puertos 80 y 8080 estén abiertos
- **Base de Datos**: Ejecutar `scripts-bbdd/schema-mysql.sql` antes de iniciar
- **Logs**: Revisar logs en caso de problemas: `sudo journalctl -u recetas`

## 🎯 Estado del Punto 4

✅ **COMPLETADO**

- Scripts de despliegue creados
- Documentación completa
- Configuración de servicios lista
- Docker configurado
- Guía paso a paso disponible

El proyecto está listo para ser desplegado en una máquina virtual.

