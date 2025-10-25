-- Tabla de roles
CREATE TABLE IF NOT EXISTS ROLE (id BIGINT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(50) UNIQUE);

-- Tabla de usuarios
CREATE TABLE IF NOT EXISTS USERS (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone VARCHAR(50),
    crops VARCHAR(255)
);

-- Tabla de relación usuario-roles
CREATE TABLE IF NOT EXISTS USER_ROLES (
    user_id BIGINT,
    role_id BIGINT,
    PRIMARY KEY (user_id, role_id),
    FOREIGN KEY (user_id) REFERENCES USERS(id),
    FOREIGN KEY (role_id) REFERENCES ROLE(id)
);

-- Tabla de maquinaria
CREATE TABLE IF NOT EXISTS MACHINERY (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(100),
    brand VARCHAR(100),
    model VARCHAR(100),
    year INTEGER,
    location VARCHAR(255),
    capacity INTEGER,
    maintenance TEXT,
    conditions TEXT,
    payment_methods VARCHAR(255),
    price_per_day DOUBLE,
    available_from DATE,
    available_to DATE,
    owner_id BIGINT,
    FOREIGN KEY (owner_id) REFERENCES USERS(id)
);

-- Tabla de reservas
CREATE TABLE IF NOT EXISTS RESERVATION (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    machinery_id BIGINT,
    renter_id BIGINT,
    start_date DATE,
    end_date DATE,
    total_price DOUBLE,
    FOREIGN KEY (machinery_id) REFERENCES MACHINERY(id),
    FOREIGN KEY (renter_id) REFERENCES USERS(id)
);
