var Card = require('../model/model');

exports.create = (req, res)=>{}

exports.find = (req, res) => {
    try {
        Card.find()
        .then(cards => {
            res.send(cards)
        })
        //const q = req.query.q;
        //let cards = Card.find();
        // if(q){
        //     console.log(`got req: ${q}`);
        //     cards = cards.filter(({ name }) => name.toLowerCase().match(q));
        // }
        //res.send(cards);
    } catch (err) {
        res.send({ message: err });
    }
}

exports.update = (req, res)=>{}

exports.delete = (req, res)=>{}
