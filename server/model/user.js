const mongoose = require('mongoose');

const UsersSchema = mongoose.Schema({
    username: {
        type: String,
    },
    email: String,
    playlists: [{
        type: mongoose.Schema.Types.ObjectId,
        ref: "Card",
    }],
})

const User = mongoose.model('User', UsersSchema)
module.exports = User;