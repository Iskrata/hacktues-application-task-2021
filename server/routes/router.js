const express = require('express');
const route = express.Router()

const controller = require('../controller/controller');

route.get('/', controller.getUsers);
route.post('/', controller.createUser);

route.get('/:userId/cards', controller.getCards)
route.get('/:userId/usercards', controller.getUserCards)
route.post('/:userId/cards', controller.createCard)

route.put('/cards/:id', controller.updateCard)
route.delete('/cards/:id', controller.deleteCard)

// API - users
// route.post('/api/users', controller.createUser);
// route.get('/api/users', controller.findUser);
// route.put('/api/users/:id', controller.update);
// route.delete('/api/users/:id', controller.delete);

// API - cards
// route.post('/api/:userID/cards', controller.createCard);
// route.get('/api/cards', controller.findCard);
// route.put('/api/cards/:id', controller.updateCard);
// route.delete('/api/cards/:id', controller.deleteCard);


module.exports = route