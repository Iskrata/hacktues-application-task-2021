const express = require('express');
const dotenv = require('dotenv');
const route = express.Router()
require('dotenv/config');

const connectDB = require('./server/database/connection');

const app = express();
const port = 3000

app.use(express.urlencoded({ extended: true }));
app.use(express.json());

connectDB();

app.use('/', require('./server/routes/router'))

app.listen(port, ()=> { console.log(`Server is running on http://localhost:${port}`)});
