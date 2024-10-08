const express = require('express');
const app = express();
const connectionDB = require("./db");
const bodyParser = require("body-parser");
const path = require("path");
const mongoose = require ("mongoose");
require("dotenv").config();
const cors = require('cors');
app.use(cors());

const JWT_SECRET = process.env.JWT_SECRET;

app.use(bodyParser.json());

//Routes
const userRoute = require("./routers/userRoute");
const petRoute = require("./routers/petRoute");
const adoptionRoute = require("./routers/adoptionRoute");

//Authentication routes
app.use("/users", userRoute);

//CRUD Pets routes 
app.use("/pets", petRoute);

//Adoption form route
app.use("/adoption", adoptionRoute);

const port = process.env.PORT || 5000;

mongoose
    .connect(process.env.MONGO_URI)
    .then(() => console.log("MongoDB connected"))
    .catch((error) => console.log("MongoDB connection error: ", error));


app.listen(port, ()=>{
    console.log(`Server is running on port http://localhost:${port}`);
});