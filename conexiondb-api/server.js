const express = require('express');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(express.json());

const estadiosRoutes = require('./routes/estadios');

app.use('/api/estadios', estadiosRoutes);

const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Servidor ejecutándose en puerto ${PORT}`);
});
