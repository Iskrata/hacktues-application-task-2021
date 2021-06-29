const mongoose = require('mongoose');

const CardsSchema = mongoose.Schema({
    name: {
        type: String,
    },
    author: String,
    url: String,
    score: {
        type: Number,
        default: 0
    },
    image: String,
    description: {
        type: String,
        default: "No description."
    },
    tags: Array
})

const Card = mongoose.model('Cards', CardsSchema)

module.exports = Card;
