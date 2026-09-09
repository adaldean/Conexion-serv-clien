from flask import Flask, render_template, request, redirect, url_for
from main import Usuario, Videojuego, Empleado, Compra

app = Flask(__name__)

@app.route('/')
def index():
	user = Usuario()
	usuarios = user.obtener_usuarios()
	user.cerrar_conexion()
	return render_template('index.html', usuarios = usuarios)

@app.route('/agregar', methods=['GET', 'POST'])
def agregar():
	if request.method == 'POST':
		datos= (
			request.form['nombre'],
			request.form['apellido'],
			request.form['correo'],
			request.form['telefono'],
			request.form['direccion'],
			request.form['delegacion'],
			request.form['pais'],
			request.form['edad']
		)

		user = Usuario()
		user.crear_usuario(*datos)
		user.cerrar_conexion()
		return redirect(url_for('index'))

	return render_template('agregar.html')

@app.route('/eliminar/<int:id_usuario>')
def eliminar(id_usuario):
	user = Usuario()
	user.eliminar_usuario(id_usuario)
	user.cerrar_conexion()
	return redirect(url_for('index'))

@app.route('/editar/<int:id_usuario>', methods= ['GET', 'POST'])
def editar(id_usuario):
	user = Usuario()
	usuario =  user.obtener_usuario_por_id(id_usuario)[0]
	if request.method == 'POST':
		datos = (
			request.form['nombre'],
			request.form['apellido'],
			request.form['correo'],
			request.form['telefono'],
			request.form['direccion'],
			request.form['delegacion'],
			request.form['pais'],
			request.form['edad'],
			id_usuario
		)
		user.actualizar_usuario(*datos)
		user.cerrar_conexion()
		return redirect(url_for('index'))
	user.cerrar_conexion()
	return render_template('editar.html', usuario=usuario)

@app.route('/dashboard')
def dashboard():
    return render_template('dashboard.html')

@app.route('/videojuegos')
def videojuegos():
    obj = Videojuego()
    data = obj.obtener_videojuegos()
    obj.cerrar_conexion()
    return render_template('videojuegos.html', videojuegos=data)

@app.route('/videojuegos/agregar', methods=['GET', 'POST'])
def agregar_videojuego():
    if request.method == 'POST':
        datos = (
            request.form['nombre'],
            request.form['genero'],
            request.form['precio']
        )
        obj = Videojuego()
        obj.crear_videojuego(*datos)
        obj.cerrar_conexion()
        return redirect(url_for('videojuegos'))

    return render_template('agregar_videojuego.html')

@app.route('/videojuegos/editar/<int:id>', methods=['GET', 'POST'])
def editar_videojuego(id):
    obj = Videojuego()
    videojuego = obj.obtener_videojuego_por_id(id)[0]

    if request.method == 'POST':
        datos = (
            request.form['nombre'],
            request.form['genero'],
            request.form['precio'],
            id
        )
        obj.actualizar_videojuego(*datos)
        obj.cerrar_conexion()
        return redirect(url_for('videojuegos'))

    obj.cerrar_conexion()
    return render_template('editar_videojuego.html', videojuego=videojuego)

@app.route('/videojuegos/eliminar/<int:id>')
def eliminar_videojuego(id):
    obj = Videojuego()
    obj.eliminar_videojuego(id)
    obj.cerrar_conexion()
    return redirect(url_for('videojuegos'))

@app.route('/empleados')
def empleados():
    obj = Empleado()
    data = obj.obtener_empleados()
    obj.cerrar_conexion()
    return render_template('empleados.html', empleados=data)

@app.route('/empleados/agregar', methods=['GET', 'POST'])
def agregar_empleado():
    if request.method == 'POST':
        datos = (
            request.form['nombre'],
            request.form['puesto'],
            request.form['salario']
        )
        obj = Empleado()
        obj.crear_empleado(*datos)
        obj.cerrar_conexion()
        return redirect(url_for('empleados'))

    return render_template('agregar_empleado.html')

@app.route('/empleados/editar/<int:id>', methods=['GET', 'POST'])
def editar_empleado(id):
    obj = Empleado()
    empleado = obj.obtener_empleado_por_id(id)[0]

    if request.method == 'POST':
        datos = (
            request.form['nombre'],
            request.form['puesto'],
            request.form['salario'],
            id
        )
        obj.actualizar_empleado(*datos)
        obj.cerrar_conexion()
        return redirect(url_for('empleados'))

    obj.cerrar_conexion()
    return render_template('editar_empleado.html', empleado=empleado)

@app.route('/empleados/eliminar/<int:id>')
def eliminar_empleado(id):
    obj = Empleado()
    obj.eliminar_empleado(id)
    obj.cerrar_conexion()
    return redirect(url_for('empleados'))

@app.route('/compras')
def compras():
    obj = Compra()
    data = obj.obtener_compras()
    obj.cerrar_conexion()
    return render_template('compras.html', compras=data)


@app.route('/compras/agregar', methods=['GET', 'POST'])
def agregar_compra():
    usuarios = Usuario().obtener_usuarios()
    videojuegos = Videojuego().obtener_videojuegos()

    if request.method == 'POST':
        datos = (
            request.form['id_usuario'],
            request.form['id_videojuego']
        )

        obj = Compra()
        obj.crear_compra(*datos)
        obj.cerrar_conexion()
        return redirect(url_for('compras'))

    return render_template('agregar_compra.html',
                           usuarios=usuarios,
                           videojuegos=videojuegos)

if __name__ == '__main__':
    app.run(debug=True, port=5001)
	