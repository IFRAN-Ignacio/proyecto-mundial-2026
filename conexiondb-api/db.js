const mysql = require('mysql2');

const conexion = mysql.createConnection({
    host: 'localhost',
    user: 'mundial_read',
    password: 'CAMBIAR_CONTRASENA',
    database: 'mundial_argentina'
});

conexion.connect((error) => {
    if (error) {
        console.error('Error de conexión:', error);
        return;
    }
    console.log('Conectado a MySQL');
});

module.exports = conexion;
