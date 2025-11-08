CREATE DATABASE IF NOT EXISTS recetas_db;
USE recetas_db;

CREATE TABLE IF NOT EXISTS usuarios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE IF NOT EXISTS roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE IF NOT EXISTS usuario_roles (
    usuario_id BIGINT NOT NULL,
    role_id BIGINT NOT NULL,
    PRIMARY KEY (usuario_id, role_id),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (role_id) REFERENCES roles(id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS recetas (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    tipo_cocina VARCHAR(100),
    pais_origen VARCHAR(100),
    dificultad VARCHAR(50),
    tiempo_coccion INT,
    descripcion TEXT,
    ingredientes TEXT,
    instrucciones TEXT,
    imagen_url VARCHAR(500),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    popularidad INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS anuncios (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    empresa VARCHAR(200) NOT NULL,
    titulo VARCHAR(200) NOT NULL,
    descripcion TEXT,
    imagen_url VARCHAR(500),
    url_destino VARCHAR(500),
    activo BOOLEAN DEFAULT TRUE
);

INSERT INTO roles (nombre) VALUES ('ROLE_USER');
INSERT INTO roles (nombre) VALUES ('ROLE_ADMIN');

INSERT INTO usuarios (username, password, email, enabled) VALUES 
('admin', '$2a$10$xLQVPjXvz8T1qy6vVqIe4.OPu1hl6cXvO8kR8jZQ8Kv0iZYJvJ8nq', 'admin@recetas.com', TRUE),
('chef', '$2a$10$xLQVPjXvz8T1qy6vVqIe4.OPu1hl6cXvO8kR8jZQ8Kv0iZYJvJ8nq', 'chef@recetas.com', TRUE),
('usuario', '$2a$10$xLQVPjXvz8T1qy6vVqIe4.OPu1hl6cXvO8kR8jZQ8Kv0iZYJvJ8nq', 'usuario@recetas.com', TRUE);

INSERT INTO usuario_roles (usuario_id, role_id) VALUES (1, 2);
INSERT INTO usuario_roles (usuario_id, role_id) VALUES (2, 1);
INSERT INTO usuario_roles (usuario_id, role_id) VALUES (3, 1);

INSERT INTO recetas (nombre, tipo_cocina, pais_origen, dificultad, tiempo_coccion, descripcion, ingredientes, instrucciones, imagen_url, popularidad) VALUES
('Paella Valenciana', 'Mediterránea', 'España', 'Media', 60, 'Plato tradicional español con arroz, pollo y mariscos', 
'Arroz, pollo, mariscos, azafrán, pimientos, judías verdes, tomate, aceite de oliva', 
'1. Sofreír el pollo\n2. Agregar verduras\n3. Añadir el arroz y caldo\n4. Cocinar por 20 minutos\n5. Dejar reposar', 
'https://images.unsplash.com/photo-1534080564583-6be75777b70a', 95),

('Tacos al Pastor', 'Mexicana', 'México', 'Media', 45, 'Tacos con carne marinada en especias mexicanas', 
'Carne de cerdo, piña, cebolla, cilantro, tortillas, especias mexicanas, limón', 
'1. Marinar la carne\n2. Asar la carne\n3. Cortar en trozos pequeños\n4. Servir en tortillas con piña, cebolla y cilantro', 
'https://images.unsplash.com/photo-1565299585323-38d6b0865b47', 88),

('Sushi Roll California', 'Japonesa', 'Japón', 'Difícil', 30, 'Rollo de sushi con cangrejo, aguacate y pepino', 
'Arroz para sushi, alga nori, cangrejo, aguacate, pepino, vinagre de arroz, wasabi', 
'1. Cocinar el arroz\n2. Extender el alga nori\n3. Colocar arroz y relleno\n4. Enrollar con bambú\n5. Cortar en porciones', 
'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351', 92),

('Pasta Carbonara', 'Italiana', 'Italia', 'Fácil', 20, 'Pasta cremosa con panceta y huevo', 
'Pasta, panceta, huevos, queso parmesano, pimienta negra, sal', 
'1. Cocinar la pasta\n2. Freír la panceta\n3. Mezclar huevos con queso\n4. Combinar todo fuera del fuego', 
'https://images.unsplash.com/photo-1612874742237-6526221588e3', 85),

('Pad Thai', 'Tailandesa', 'Tailandia', 'Media', 25, 'Fideos salteados con salsa de tamarindo', 
'Fideos de arroz, camarones, huevo, brotes de soja, cacahuates, salsa de pescado, tamarindo', 
'1. Remojar los fideos\n2. Saltear camarones\n3. Agregar fideos y salsa\n4. Añadir huevo\n5. Servir con cacahuates', 
'https://images.unsplash.com/photo-1559314809-0d155014e29e', 78),

('Empanadas Argentinas', 'Latinoamericana', 'Argentina', 'Media', 40, 'Empanadas rellenas de carne', 
'Masa para empanadas, carne molida, cebolla, huevo duro, aceitunas, comino, pimentón', 
'1. Preparar el relleno\n2. Rellenar las empanadas\n3. Cerrar con repulgue\n4. Hornear por 25 minutos', 
'https://images.unsplash.com/photo-1601050690597-df0568f70950', 82);

INSERT INTO anuncios (empresa, titulo, descripcion, imagen_url, url_destino, activo) VALUES
('Utensilios Gourmet', '¡Descuento 30% en Ollas!', 'Las mejores ollas profesionales para tu cocina', 
'https://images.unsplash.com/photo-1556911220-bff31c812dba', '#', TRUE),

('Supermercado Fresh', 'Ingredientes Frescos Diarios', 'Los mejores ingredientes para tus recetas', 
'https://images.unsplash.com/photo-1542838132-92c53300491e', '#', TRUE),

('Escuela de Cocina Chef', 'Cursos Online de Cocina', 'Aprende de los mejores chefs profesionales', 
'https://images.unsplash.com/photo-1556910096-6f5e72db6803', '#', TRUE);