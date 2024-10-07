const express = require('express');
const app = express();
const connectionDB = require("./db");
const bodyParser = require("body-parser");
const path = require("path");
const mongoose = require ("mongoose");
require("dotenv").config();


const JWT_SECRET = process.env.JWT_SECRET;

app.use(bodyParser.json());

//Routes
const userRoute = require("./routers/Routes");

app.use("/users", userRoute);

const port = process.env.PORT || 5000;

mongoose
    .connect(process.env.MONGO_URI)
    .then(() => console.log("MongoDB connected"))
    .catch((error) => console.log("MongoDB connection error: ", error));


app.listen(port, ()=>{
    console.log(`Server is running on port http://localhost:${port}`);
});