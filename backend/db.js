const mongoose = require("mongoose");
require("dotenv").config();

const MongoURI = process.env.MONGO_URI;

const connectonDB = async () => {
    try {
        await mongoose.connect(MongoURI,{
            serverSelectionTimeoutMS: 20000,
        });
        console.log("MongoDB connected")
    } catch (error) {
        console.error("Error connecting to MongoDB: ", err.message);
        process.exit(1);
    }
};

module.exports = connectonDB;