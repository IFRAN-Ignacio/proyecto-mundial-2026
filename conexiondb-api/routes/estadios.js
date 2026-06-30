const express = require('express');
const router = express.Router();
const conexion = require('../db');

router.get('/', (req, res) => {
    conexion.query('SELECT * FROM estadio', (error, resultados) => {
        if (error) {
            return res.status(500).json(error);
        }
        res.json(resultados);
    });
});

module.exports = router;
