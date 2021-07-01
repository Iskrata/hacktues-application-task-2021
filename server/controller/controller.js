var Card = require('../model/card');
var User = require('../model/user');

exports.getUsers = (req, res)=>{
    try {
        User.find()
        .then(users => {
            res.send(users)
        })
    } catch (err) {
        res.send({ message: err });
    }
}

exports.createUser = (req, res)=>{
    const newUser = new User(req.body);
    const user = newUser.save();
    res.json(user);
}

exports.updateUser = (req, res)=>{
    if(!req.body){
        return res
            .status(400)
            .send({ message : "Empty req"})
    }

    const id = req.params.id;
    User.findByIdAndUpdate(id, req.body, { useFindAndModify: false})
        .then(data => {
            if(!data){
                res.status(404).send({ message : `Cannot Update user with ${id}. The user doesn't exist`})
            }else{
                res.send(data)
            }
        })
        .catch(err =>{
            res.status(500).send({ message : "Error Update user information"})
        })
}


// CARDS

exports.createCard = (req, res)=>{
    const { userId } = req.params;
    User.findById(userId)
        .then(user => {
            const newCard = new Card({
                name: req.body.name,
                author: user,
                url: req.body.url,
                score: req.body.score,
                image: req.body.image,
                description: req.body.description,
                tags: req.body.tags
            });
            newCard.save()
            user.playlists.push(newCard)
            user.save()
            res.json(newCard)           
        })
}

exports.getUserCards = (req, res)=>{
    const { userId } = req.params;
    User.findById(userId).populate("cards")
        .then(user => {
            res.send(user.playlists);
        })
}

exports.getCards = (req, res)=>{
    try {
        Card.find()
        .then(cards => {
            res.send(cards)
        })
    } catch (err) {
        res.send({ message: err });
    }
}

exports.updateCard = (req, res)=>{
    if(!req.body){
        return res
            .status(400)
            .send({ message : "Empty req"})
    }

    const id = req.params.id;
    Card.findByIdAndUpdate(id, req.body, { useFindAndModify: false})
        .then(data => {
            if(!data){
                res.status(404).send({ message : `Cannot Update card with ${id}. The card doesn't exist`})
            }else{
                res.send(data)
            }
        })
        .catch(err =>{
            res.status(500).send({ message : "Error Update card information"})
        })
}

exports.deleteCard = (req, res)=>{
    const id = req.params.id;

    Card.findByIdAndDelete(id)
        .then(data => {
            res.send({
                message : "Card was deleted successfully!"
            })
        })
        .catch(err =>{
            res.status(500).send({
                message: "Could not delete Card with id=" + id
            });
        });
}
