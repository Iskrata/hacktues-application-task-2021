const mongoose = require('mongoose');

const connectDB = async () => {
    try{
        mongoose.connect(process.env.DB_CONNECTION,
            {useNewUrlParser: true, useUnifiedTopology: true,  useFindAndModify: false, useCreateIndex: true},
            () => console.log("connected!")
        )
    }catch(err){
        console.log(err);
        process.exit(1);
    }
}

module.exports = connectDB