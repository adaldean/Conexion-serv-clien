--
-- Esquema PostgreSQL para una plataforma e-commerce de claves digitales.
-- Compatible con PostgreSQL 14+.
--

BEGIN;

SET client_encoding = 'UTF8';
SET search_path = public;

-- Permite ejecutar el script nuevamente durante desarrollo.
DROP TABLE IF EXISTS compras CASCADE;
DROP TABLE IF EXISTS keys_digitales CASCADE;
DROP TABLE IF EXISTS empleados CASCADE;
DROP TABLE IF EXISTS videojuegos CASCADE;
DROP TABLE IF EXISTS usuarios CASCADE;

CREATE TABLE usuarios (
    id_usuario SERIAL CONSTRAINT usuarios_pkey PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    correo VARCHAR(100) CONSTRAINT usuarios_correo_key UNIQUE NOT NULL,
    telefono VARCHAR(20),
    direccion VARCHAR(100),
    delegacion VARCHAR(50),
    pais VARCHAR(50),
    edad INTEGER,
    password_hash VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL DEFAULT 'cliente',
    CONSTRAINT usuarios_rol_check CHECK (rol IN ('cliente', 'admin'))
);

CREATE TABLE videojuegos (
    id_videojuego SERIAL CONSTRAINT videojuegos_pkey PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    precio NUMERIC(10, 2) NOT NULL,
    plataforma VARCHAR(50) NOT NULL DEFAULT 'Steam',
    imagen_url VARCHAR(255),
    descripcion TEXT,
    CONSTRAINT videojuegos_precio_check CHECK (precio >= 0)
);

CREATE TABLE keys_digitales (
    id_key SERIAL CONSTRAINT keys_digitales_pkey PRIMARY KEY,
    id_videojuego INTEGER NOT NULL,
    codigo_key VARCHAR(100) CONSTRAINT keys_digitales_codigo_key_key UNIQUE NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'disponible',
    CONSTRAINT keys_digitales_estado_check
        CHECK (estado IN ('disponible', 'vendida')),
    CONSTRAINT keys_digitales_videojuego_fkey
        FOREIGN KEY (id_videojuego)
        REFERENCES videojuegos (id_videojuego)
        ON DELETE CASCADE
);

CREATE TABLE empleados (
    id_empleado SERIAL CONSTRAINT empleados_pkey PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    puesto VARCHAR(50),
    salario NUMERIC(10, 2),
    CONSTRAINT empleados_salario_check CHECK (salario IS NULL OR salario >= 0)
);

CREATE TABLE compras (
    id_compra SERIAL CONSTRAINT compras_pkey PRIMARY KEY,
    id_usuario INTEGER NOT NULL,
    id_key INTEGER NOT NULL,
    total NUMERIC(10, 2) NOT NULL,
    fecha TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT compras_usuario_fkey
        FOREIGN KEY (id_usuario)
        REFERENCES usuarios (id_usuario),
    CONSTRAINT compras_key_fkey
        FOREIGN KEY (id_key)
        REFERENCES keys_digitales (id_key),
    CONSTRAINT compras_total_check CHECK (total >= 0)
);

-- Documentación de la unicidad: evita registrar el mismo correo o código dos veces.
COMMENT ON CONSTRAINT usuarios_correo_key ON usuarios
    IS 'El correo identifica de forma única a cada usuario.';
COMMENT ON CONSTRAINT keys_digitales_codigo_key_key ON keys_digitales
    IS 'Cada clave de activación solo puede existir una vez en el inventario.';

-- Documentación de las relaciones entre compras, usuarios, claves y videojuegos.
COMMENT ON CONSTRAINT keys_digitales_videojuego_fkey ON keys_digitales
    IS 'Cada clave pertenece a un videojuego; al eliminarlo, se eliminan sus claves.';
COMMENT ON CONSTRAINT compras_usuario_fkey ON compras
    IS 'Relaciona la compra con el usuario que la realizó.';
COMMENT ON CONSTRAINT compras_key_fkey ON compras
    IS 'Relaciona la compra con la clave digital entregada.';

-- Los valores de password_hash son hashes ficticios de ejemplo.
-- La contrasena original no puede recuperarse desde un hash.
-- En produccion, genera el hash en la aplicacion con bcrypt o Argon2.
INSERT INTO usuarios (
    nombre, apellido, correo, telefono, direccion, delegacion, pais, edad,
    password_hash, rol
) VALUES
    (
        'Ana', 'García', 'ana.garcia@example.com', '5551001001',
        'Av. Reforma 100', 'Cuauhtémoc', 'México', 28,
        '$2b$12$LQv3c1yqBWxR7kD7dQJ8UOQ7vD0Q5j5kGQ7m4g8W3t2r1n0p9q8s6',
        'cliente'
    ),
    (
        'Luis', 'Ramírez', 'luis.ramirez@example.com', '5551001002',
        'Calle Insurgentes 200', 'Benito Juárez', 'México', 35,
        '$2b$12$N9qo8uLOickgx2ZMRZoMyeIjZAgcfl7p92ldGxad68LJZdL17lhWy',
        'admin'
    );

INSERT INTO videojuegos (
    titulo, genero, precio, plataforma, imagen_url, descripcion
) VALUES
    (
        'The Legend of Zelda: Breath of the Wild', 'Aventura', 59.99,
        'Nintendo Switch', NULL, 'Aventura de mundo abierto en Hyrule.'
    ),
    (
        'Forza Horizon 5', 'Carreras', 49.99,
        'Xbox', NULL, 'Juego de carreras de mundo abierto.'
    );

INSERT INTO keys_digitales (id_videojuego, codigo_key)
SELECT id_videojuego, codigo_key
FROM (
    VALUES
        ('The Legend of Zelda: Breath of the Wild', 'ZELDA-DEMO-0001'),
        ('The Legend of Zelda: Breath of the Wild', 'ZELDA-DEMO-0002'),
        ('The Legend of Zelda: Breath of the Wild', 'ZELDA-DEMO-0003'),
        ('Forza Horizon 5', 'FORZA-DEMO-0001'),
        ('Forza Horizon 5', 'FORZA-DEMO-0002')
) AS datos(titulo, codigo_key)
JOIN videojuegos USING (titulo);

COMMIT;
