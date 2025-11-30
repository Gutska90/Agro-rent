-- Script SQL para Oracle Database
-- Base de datos: recetas
-- Compatible con Oracle 11g y superiores

-- Eliminar tablas si existen (en orden inverso de dependencias)
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE receta_compartidas CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE receta_videos CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE receta_fotos CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE valoraciones CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE comentarios CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE usuario_roles CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE anuncios CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE recetas CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE usuarios CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE roles CASCADE CONSTRAINTS';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Eliminar secuencias si existen
BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE roles_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE usuarios_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE recetas_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE anuncios_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE comentarios_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE valoraciones_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE receta_fotos_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE receta_videos_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP SEQUENCE receta_compartidas_seq';
   EXCEPTION WHEN OTHERS THEN NULL;
END;
/

-- Crear secuencias
CREATE SEQUENCE roles_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE usuarios_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE recetas_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE anuncios_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE comentarios_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE valoraciones_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE receta_fotos_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE receta_videos_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE receta_compartidas_seq START WITH 1 INCREMENT BY 1;

-- Crear tabla roles
CREATE TABLE roles (
    id NUMBER(19) PRIMARY KEY,
    nombre VARCHAR2(50) UNIQUE NOT NULL
);

-- Crear tabla usuarios
CREATE TABLE usuarios (
    id NUMBER(19) PRIMARY KEY,
    nombre_completo VARCHAR2(200) NOT NULL,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password VARCHAR2(255) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    enabled NUMBER(1) DEFAULT 1 CHECK (enabled IN (0,1))
);

-- Crear tabla usuario_roles
CREATE TABLE usuario_roles (
    usuario_id NUMBER(19) NOT NULL,
    role_id NUMBER(19) NOT NULL,
    PRIMARY KEY (usuario_id, role_id),
    CONSTRAINT fk_usuario_oracle FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT fk_role_oracle FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

-- Crear tabla recetas
CREATE TABLE recetas (
    id NUMBER(19) PRIMARY KEY,
    nombre VARCHAR2(200) NOT NULL,
    tipo_cocina VARCHAR2(100),
    pais_origen VARCHAR2(100),
    dificultad VARCHAR2(50),
    tiempo_coccion NUMBER(10),
    descripcion CLOB,
    ingredientes CLOB,
    instrucciones CLOB,
    imagen_url VARCHAR2(500),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    popularidad NUMBER(10) DEFAULT 0
);

-- Crear tabla anuncios
CREATE TABLE anuncios (
    id NUMBER(19) PRIMARY KEY,
    empresa VARCHAR2(200) NOT NULL,
    titulo VARCHAR2(200) NOT NULL,
    descripcion CLOB,
    imagen_url VARCHAR2(500),
    url_destino VARCHAR2(500),
    activo NUMBER(1) DEFAULT 1 CHECK (activo IN (0,1))
);

-- Crear tabla comentarios
CREATE TABLE comentarios (
    id NUMBER(19) PRIMARY KEY,
    receta_id NUMBER(19) NOT NULL,
    usuario_id NUMBER(19) NOT NULL,
    comentario CLOB NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comentario_receta_oracle FOREIGN KEY (receta_id) REFERENCES recetas(id) ON DELETE CASCADE,
    CONSTRAINT fk_comentario_usuario_oracle FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Crear tabla valoraciones
CREATE TABLE valoraciones (
    id NUMBER(19) PRIMARY KEY,
    receta_id NUMBER(19) NOT NULL,
    usuario_id NUMBER(19) NOT NULL,
    puntuacion NUMBER(1) NOT NULL CHECK (puntuacion >= 1 AND puntuacion <= 5),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion TIMESTAMP,
    CONSTRAINT fk_valoracion_receta_oracle FOREIGN KEY (receta_id) REFERENCES recetas(id) ON DELETE CASCADE,
    CONSTRAINT fk_valoracion_usuario_oracle FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    CONSTRAINT unique_valoracion_oracle UNIQUE (receta_id, usuario_id)
);

-- Crear tabla receta_fotos
CREATE TABLE receta_fotos (
    id NUMBER(19) PRIMARY KEY,
    receta_id NUMBER(19) NOT NULL,
    url_foto VARCHAR2(500) NOT NULL,
    nombre_archivo VARCHAR2(255),
    tipo_archivo VARCHAR2(50),
    tamaño_archivo NUMBER(19),
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    es_principal NUMBER(1) DEFAULT 0 CHECK (es_principal IN (0,1)),
    CONSTRAINT fk_foto_receta_oracle FOREIGN KEY (receta_id) REFERENCES recetas(id) ON DELETE CASCADE
);

-- Crear tabla receta_videos
CREATE TABLE receta_videos (
    id NUMBER(19) PRIMARY KEY,
    receta_id NUMBER(19) NOT NULL,
    url_video VARCHAR2(500) NOT NULL,
    nombre_archivo VARCHAR2(255),
    tipo_archivo VARCHAR2(50),
    tamaño_archivo NUMBER(19),
    duracion_segundos NUMBER(10),
    fecha_subida TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_video_receta_oracle FOREIGN KEY (receta_id) REFERENCES recetas(id) ON DELETE CASCADE
);

-- Crear tabla receta_compartidas
CREATE TABLE receta_compartidas (
    id NUMBER(19) PRIMARY KEY,
    receta_id NUMBER(19) NOT NULL,
    usuario_id NUMBER(19) NOT NULL,
    plataforma VARCHAR2(50),
    fecha_compartido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_compartida_receta_oracle FOREIGN KEY (receta_id) REFERENCES recetas(id) ON DELETE CASCADE,
    CONSTRAINT fk_compartida_usuario_oracle FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

-- Crear triggers para auto-incrementar IDs
CREATE OR REPLACE TRIGGER roles_bir 
BEFORE INSERT ON roles 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT roles_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER usuarios_bir 
BEFORE INSERT ON usuarios 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT usuarios_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER recetas_bir 
BEFORE INSERT ON recetas 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT recetas_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER anuncios_bir 
BEFORE INSERT ON anuncios 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT anuncios_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER comentarios_bir 
BEFORE INSERT ON comentarios 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT comentarios_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER valoraciones_bir 
BEFORE INSERT ON valoraciones 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT valoraciones_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER receta_fotos_bir 
BEFORE INSERT ON receta_fotos 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT receta_fotos_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER receta_videos_bir 
BEFORE INSERT ON receta_videos 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT receta_videos_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER receta_compartidas_bir 
BEFORE INSERT ON receta_compartidas 
FOR EACH ROW
BEGIN
  IF :NEW.id IS NULL THEN
    SELECT receta_compartidas_seq.NEXTVAL INTO :NEW.id FROM DUAL;
  END IF;
END;
/

-- Insertar roles
INSERT INTO roles (nombre) VALUES ('ROLE_USER');
INSERT INTO roles (nombre) VALUES ('ROLE_ADMIN');

-- Insertar usuarios de prueba (password: password123)
-- Nota: En producción, usar contraseñas reales encriptadas con BCrypt
INSERT INTO usuarios (nombre_completo, username, password, email, enabled) VALUES 
('Administrador del Sistema', 'admin', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyY5Y5Y5Y5Y5', 'admin@recetas.com', 1);

INSERT INTO usuarios (nombre_completo, username, password, email, enabled) VALUES 
('Chef Profesional', 'chef', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyY5Y5Y5Y5Y5', 'chef@recetas.com', 1);

INSERT INTO usuarios (nombre_completo, username, password, email, enabled) VALUES 
('Usuario Común', 'usuario', '$2a$12$LQv3c1yqBWVHxkd0LHAkCOYz6TtxMQJqhN8/LewY5GyY5Y5Y5Y5Y5', 'usuario@recetas.com', 1);

-- Asignar roles a usuarios
INSERT INTO usuario_roles (usuario_id, role_id) VALUES (1, 2); -- admin tiene ROLE_ADMIN
INSERT INTO usuario_roles (usuario_id, role_id) VALUES (2, 1); -- chef tiene ROLE_USER
INSERT INTO usuario_roles (usuario_id, role_id) VALUES (3, 1); -- usuario tiene ROLE_USER

-- Insertar recetas de ejemplo
INSERT INTO recetas (nombre, tipo_cocina, pais_origen, dificultad, tiempo_coccion, descripcion, ingredientes, instrucciones, imagen_url, popularidad) VALUES
('Paella Valenciana', 'Mediterránea', 'España', 'Media', 60, 'Plato tradicional español con arroz, pollo y mariscos', 
'Arroz, pollo, mariscos, azafrán, pimientos, judías verdes, tomate, aceite de oliva', 
'1. Sofreír el pollo' || CHR(10) || '2. Agregar verduras' || CHR(10) || '3. Añadir el arroz y caldo' || CHR(10) || '4. Cocinar por 20 minutos' || CHR(10) || '5. Dejar reposar', 
'https://images.unsplash.com/photo-1534080564583-6be75777b70a', 95);

INSERT INTO recetas (nombre, tipo_cocina, pais_origen, dificultad, tiempo_coccion, descripcion, ingredientes, instrucciones, imagen_url, popularidad) VALUES
('Tacos al Pastor', 'Mexicana', 'México', 'Media', 45, 'Tacos con carne marinada en especias mexicanas', 
'Carne de cerdo, piña, cebolla, cilantro, tortillas, especias mexicanas, limón', 
'1. Marinar la carne' || CHR(10) || '2. Asar la carne' || CHR(10) || '3. Cortar en trozos pequeños' || CHR(10) || '4. Servir en tortillas con piña, cebolla y cilantro', 
'https://images.unsplash.com/photo-1565299585323-38d6b0865b47', 88);

INSERT INTO recetas (nombre, tipo_cocina, pais_origen, dificultad, tiempo_coccion, descripcion, ingredientes, instrucciones, imagen_url, popularidad) VALUES
('Sushi Roll California', 'Japonesa', 'Japón', 'Difícil', 30, 'Rollo de sushi con cangrejo, aguacate y pepino', 
'Arroz para sushi, alga nori, cangrejo, aguacate, pepino, vinagre de arroz, wasabi', 
'1. Cocinar el arroz' || CHR(10) || '2. Extender el alga nori' || CHR(10) || '3. Colocar arroz y relleno' || CHR(10) || '4. Enrollar con bambú' || CHR(10) || '5. Cortar en porciones', 
'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351', 92);

INSERT INTO recetas (nombre, tipo_cocina, pais_origen, dificultad, tiempo_coccion, descripcion, ingredientes, instrucciones, imagen_url, popularidad) VALUES
('Pasta Carbonara', 'Italiana', 'Italia', 'Fácil', 20, 'Pasta cremosa con panceta y huevo', 
'Pasta, panceta, huevos, queso parmesano, pimienta negra, sal', 
'1. Cocinar la pasta' || CHR(10) || '2. Freír la panceta' || CHR(10) || '3. Mezclar huevos con queso' || CHR(10) || '4. Combinar todo fuera del fuego', 
'https://images.unsplash.com/photo-1612874742237-6526221588e3', 85);

INSERT INTO recetas (nombre, tipo_cocina, pais_origen, dificultad, tiempo_coccion, descripcion, ingredientes, instrucciones, imagen_url, popularidad) VALUES
('Pad Thai', 'Tailandesa', 'Tailandia', 'Media', 25, 'Fideos salteados con salsa de tamarindo', 
'Fideos de arroz, camarones, huevo, brotes de soja, cacahuates, salsa de pescado, tamarindo', 
'1. Remojar los fideos' || CHR(10) || '2. Saltear camarones' || CHR(10) || '3. Agregar fideos y salsa' || CHR(10) || '4. Añadir huevo' || CHR(10) || '5. Servir con cacahuates', 
'https://images.unsplash.com/photo-1559314809-0d155014e29e', 78);

INSERT INTO recetas (nombre, tipo_cocina, pais_origen, dificultad, tiempo_coccion, descripcion, ingredientes, instrucciones, imagen_url, popularidad) VALUES
('Empanadas Argentinas', 'Latinoamericana', 'Argentina', 'Media', 40, 'Empanadas rellenas de carne', 
'Masa para empanadas, carne molida, cebolla, huevo duro, aceitunas, comino, pimentón', 
'1. Preparar el relleno' || CHR(10) || '2. Rellenar las empanadas' || CHR(10) || '3. Cerrar con repulgue' || CHR(10) || '4. Hornear por 25 minutos', 
'https://images.unsplash.com/photo-1601050690597-df0568f70950', 82);

-- Insertar anuncios
INSERT INTO anuncios (empresa, titulo, descripcion, imagen_url, url_destino, activo) VALUES
('Utensilios Gourmet', '¡Descuento 30% en Ollas!', 'Las mejores ollas profesionales para tu cocina', 
'https://images.unsplash.com/photo-1556911220-bff31c812dba', '#', 1);

INSERT INTO anuncios (empresa, titulo, descripcion, imagen_url, url_destino, activo) VALUES
('Supermercado Fresh', 'Ingredientes Frescos Diarios', 'Los mejores ingredientes para tus recetas', 
'https://images.unsplash.com/photo-1542838132-92c53300491e', '#', 1);

INSERT INTO anuncios (empresa, titulo, descripcion, imagen_url, url_destino, activo) VALUES
('Escuela de Cocina Chef', 'Cursos Online de Cocina', 'Aprende de los mejores chefs profesionales', 
'https://images.unsplash.com/photo-1556910096-6f5e72db6803', '#', 1);

-- Confirmar transacción
COMMIT;

-- Verificar tablas creadas
SELECT table_name FROM user_tables WHERE table_name IN 
('ROLES', 'USUARIOS', 'USUARIO_ROLES', 'RECETAS', 'ANUNCIOS', 
 'COMENTARIOS', 'VALORACIONES', 'RECETA_FOTOS', 'RECETA_VIDEOS', 'RECETA_COMPARTIDAS')
ORDER BY table_name;

-- Verificar datos insertados
SELECT 'Roles' as tabla, COUNT(*) as cantidad FROM roles
UNION ALL
SELECT 'Usuarios', COUNT(*) FROM usuarios
UNION ALL
SELECT 'Recetas', COUNT(*) FROM recetas
UNION ALL
SELECT 'Anuncios', COUNT(*) FROM anuncios;

