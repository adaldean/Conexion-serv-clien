import psycopg2

# =====================================================
# CLASE BASE PARA CONEXIÓN A POSTGRES
# =====================================================

class BaseDatos:
    def __init__(self):
        self.conn = psycopg2.connect(
            host="localhost",
            database="crud_en_flask",     # <-- Cambiar por tu BD
            user="admin",      # <-- Cambiar
            password="12345"  # <-- Cambiar
        )
        self.cursor = self.conn.cursor()

    def cerrar_conexion(self):
        self.cursor.close()
        self.conn.close()


# =====================================================
# CRUD DE USUARIOS
# =====================================================

class Usuario(BaseDatos):

    def obtener_usuarios(self):
        self.cursor.execute("SELECT * FROM usuarios ORDER BY id_usuario ASC")
        return self.cursor.fetchall()

    def obtener_usuario_por_id(self, id_usuario):
        self.cursor.execute(
            "SELECT * FROM usuarios WHERE id_usuario = %s",
            (id_usuario,)
        )
        return self.cursor.fetchall()

    def crear_usuario(self, nombre, apellido, correo, telefono, direccion, delegacion, pais, edad):
        self.cursor.execute("""
            INSERT INTO usuarios (nombre, apellido, correo, telefono, direccion, delegacion, pais, edad)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s)
        """, (nombre, apellido, correo, telefono, direccion, delegacion, pais, edad))
        self.conn.commit()

    def actualizar_usuario(self, nombre, apellido, correo, telefono, direccion, delegacion, pais, edad, id_usuario):
        self.cursor.execute("""
            UPDATE usuarios
            SET nombre=%s, apellido=%s, correo=%s, telefono=%s, direccion=%s, delegacion=%s, pais=%s, edad=%s
            WHERE id_usuario=%s
        """, (nombre, apellido, correo, telefono, direccion, delegacion, pais, edad, id_usuario))
        self.conn.commit()

    def eliminar_usuario(self, id_usuario):
        self.cursor.execute("DELETE FROM usuarios WHERE id_usuario = %s", (id_usuario,))
        self.conn.commit()


# =====================================================
# CRUD DE VIDEOJUEGOS
# =====================================================

class Videojuego(BaseDatos):

    def obtener_videojuegos(self):
        self.cursor.execute("SELECT * FROM videojuegos ORDER BY id_videojuego ASC")
        return self.cursor.fetchall()

    def obtener_videojuego_por_id(self, id_videojuego):
        self.cursor.execute("SELECT * FROM videojuegos WHERE id_videojuego = %s", (id_videojuego,))
        return self.cursor.fetchall()

    def crear_videojuego(self, titulo, genero, precio):
        self.cursor.execute("""
            INSERT INTO videojuegos (titulo, genero, precio)
            VALUES (%s,%s,%s)
        """, (titulo, genero, precio))
        self.conn.commit()

    def actualizar_videojuego(self, titulo, genero, precio, id_videojuego):
        self.cursor.execute("""
            UPDATE videojuegos
            SET titulo=%s, genero=%s, precio=%s
            WHERE id_videojuego=%s
        """, (titulo, genero, precio, id_videojuego))
        self.conn.commit()

    def eliminar_videojuego(self, id_videojuego):
        self.cursor.execute("DELETE FROM videojuegos WHERE id_videojuego = %s", (id_videojuego,))
        self.conn.commit()


# =====================================================
# CRUD DE EMPLEADOS
# =====================================================

class Empleado(BaseDatos):

    def obtener_empleados(self):
        self.cursor.execute("SELECT * FROM empleados ORDER BY id_empleado ASC")
        return self.cursor.fetchall()

    def obtener_empleado_por_id(self, id_empleado):
        self.cursor.execute("SELECT * FROM empleados WHERE id_empleado = %s", (id_empleado,))
        return self.cursor.fetchall()

    def crear_empleado(self, nombre, puesto, salario):
        self.cursor.execute("""
            INSERT INTO empleados (nombre, puesto, salario)
            VALUES (%s,%s,%s)
        """, (nombre, puesto, salario))
        self.conn.commit()

    def actualizar_empleado(self, nombre, puesto, salario, id_empleado):
        self.cursor.execute("""
            UPDATE empleados
            SET nombre=%s, puesto=%s, salario=%s
            WHERE id_empleado=%s
        """, (nombre, puesto, salario, id_empleado))
        self.conn.commit()

    def eliminar_empleado(self, id_empleado):
        self.cursor.execute("DELETE FROM empleados WHERE id_empleado = %s", (id_empleado,))
        self.conn.commit()


# =====================================================
# CRUD DE COMPRAS (USUARIO + VIDEOJUEGO)
# =====================================================

class Compra(BaseDatos):

    def obtener_compras(self):
        self.cursor.execute("""
            SELECT c.id_compra,
                   u.id_usuario,
                   u.nombre || ' ' || u.apellido AS nombre_usuario,
                   v.id_videojuego,
                   v.titulo AS nombre_videojuego,
                    c.fecha
            FROM compras c
            JOIN usuarios u ON c.id_usuario = u.id_usuario
            JOIN videojuegos v ON c.id_videojuego = v.id_videojuego
            ORDER BY c.id_compra;
        """)
        return self.cursor.fetchall()


    def crear_compra(self, id_usuario, id_videojuego):
        self.cursor.execute("""
            INSERT INTO compras (id_usuario, id_videojuego)
            VALUES (%s,%s)
        """, (id_usuario, id_videojuego))
        self.conn.commit()

    def eliminar_compra(self, id_compra):
        self.cursor.execute("DELETE FROM compras WHERE id_compra = %s", (id_compra,))
        self.conn.commit()