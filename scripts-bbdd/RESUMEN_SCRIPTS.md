# Resumen de Scripts de Base de Datos

## ✅ Scripts Creados

### 1. `schema-mysql.sql` (178 líneas)
- ✅ Script completo para MySQL/MariaDB
- ✅ Incluye todas las tablas (10 tablas)
- ✅ Datos de prueba incluidos
- ✅ Sintaxis MySQL estándar

### 2. `schema-oracle.sql` (423 líneas)
- ✅ Script completo para Oracle Database
- ✅ Incluye todas las tablas (10 tablas)
- ✅ Secuencias y triggers para auto-increment
- ✅ Datos de prueba incluidos
- ✅ Sintaxis Oracle PL/SQL

### 3. Documentación
- ✅ `README_SCRIPTS.md` - Guía general de ambos scripts
- ✅ `INSTRUCCIONES_ORACLE.md` - Guía específica para Oracle
- ✅ `application-oracle.properties.example` - Configuración de ejemplo

## Estructura de Tablas

Ambos scripts crean las mismas 10 tablas:

1. **roles** - Roles del sistema
2. **usuarios** - Usuarios
3. **usuario_roles** - Relación usuarios-roles
4. **recetas** - Recetas
5. **anuncios** - Anuncios
6. **comentarios** - Comentarios en recetas (NUEVO)
7. **valoraciones** - Valoraciones 1-5 estrellas (NUEVO)
8. **receta_fotos** - Fotos de recetas (NUEVO)
9. **receta_videos** - Videos de recetas (NUEVO)
10. **receta_compartidas** - Registro de compartidos (NUEVO)

## Datos de Prueba

Ambos scripts incluyen:
- 2 roles (ROLE_USER, ROLE_ADMIN)
- 3 usuarios (admin, chef, usuario)
- 6 recetas de ejemplo
- 3 anuncios

## Diferencias Principales

| Característica | MySQL | Oracle |
|---------------|-------|--------|
| Auto-increment | `AUTO_INCREMENT` | Secuencias + Triggers |
| Tipos numéricos | `BIGINT` | `NUMBER(19)` |
| Tipos texto | `VARCHAR`, `TEXT` | `VARCHAR2`, `CLOB` |
| Booleanos | `TINYINT(1)` | `NUMBER(1)` |
| Líneas nuevas | `\n` | `CHR(10)` |

## Cómo Usar

### MySQL:
```bash
mysql -u root -p < scripts-bbdd/schema-mysql.sql
```

### Oracle:
```bash
sqlplus usuario/password@servidor @scripts-bbdd/schema-oracle.sql
```

## Estado

✅ **Completado:** Ambos scripts están listos para usar
✅ **Probado:** Sintaxis verificada
✅ **Documentado:** Guías de uso incluidas

