INSERT INTO ROLE(name) VALUES ('ROLE_USER');
INSERT INTO ROLE(name) VALUES ('ROLE_ADMIN');

-- 3 usuarios (password: 123456)
INSERT INTO USERS(id, name, email, password, address, phone, crops) VALUES
 (1,'Admin','admin@agro.cl','$2a$10$Hf1W9o1xESe7r8k1oQ9yEu8xqFqX2cN0F3h1z1wM0QWm3Q6eL3RIm','Santiago','+56 9 1111 1111','Trigo'),
 (2,'Juan Perez','juan@agro.cl','$2a$10$Hf1W9o1xESe7r8k1oQ9yEu8xqFqX2cN0F3h1z1wM0QWm3Q6eL3RIm','Rancagua','+56 9 2222 2222','Maíz'),
 (3,'Maria Lopez','maria@agro.cl','$2a$10$Hf1W9o1xESe7r8k1oQ9yEu8xqFqX2cN0F3h1z1wM0QWm3Q6eL3RIm','Talca','+56 9 3333 3333','Papás');

-- roles
INSERT INTO USER_ROLES(user_id, role_id) VALUES (1, 2);
INSERT INTO USER_ROLES(user_id, role_id) VALUES (2, 1);
INSERT INTO USER_ROLES(user_id, role_id) VALUES (3, 1);

-- maquinaria demo
INSERT INTO MACHINERY(id, type, brand, model, year, location, capacity, maintenance, conditions, payment_methods, price_per_day, available_from, available_to, owner_id)
VALUES
 (1,'Tractor','John Deere','T-100',2018,'Rancagua',120,'Mantención al día','Mínimo 2 días, combustible no incluido','Efectivo, Transferencia',55000,'2025-10-01','2025-12-31',2),
 (2,'Cosechadora','New Holland','CX6',2020,'Talca',300,'Cambio de aceite reciente','Depósito garantía $50.000','Transferencia',120000,'2025-10-10','2025-11-30',3);
