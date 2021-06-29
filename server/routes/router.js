const express = require('express');
const route = express.Router()

const controller = require('../controller/controller');

// API
route.post('/api/cards', controller.create);
route.get('/api/cards', controller.find);
route.put('/api/cards/:id', controller.update);
route.delete('/api/cards/:id', controller.delete);


module.exports = route