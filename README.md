# Conexion-Inalambrica-de-Crud-
Para habilitar la conexion entre la DBA Y CLIENTE 
Editar el archivo de configuración postgresql.conf
Ubícalo en la carpeta de datos de tu instalación (ejemplo: /etc/postgresql/15/main/postgresql.conf en Linux).
Buscar la linea #listen_addresses = 'localhost', cambiarlo por listen_addresses = '*'
. Configurar reglas de acceso en pg_hba.conf
Archivo normalmente en la misma carpeta (/etc/postgresql/15/main/pg_hba.conf).

Agrega una línea al final para permitir conexiones desde cualquier IP:
host    all    all    0.0.0.0/0    md5
Despues sudo systemctl restart postgresql
Por defecto el puerto de Firewall esta abierto, pero en el caso de que no ejecutar este comando
sudo ufw allow 5432/tcp

Para conectarse debe de estar en psql y ejecutar este codigo OJO es un ejemplo (psql -h <IP_DEL_SERVIDOR> -U <usuario> -d <base_de_datos>
)
