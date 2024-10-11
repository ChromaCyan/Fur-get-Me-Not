const express = require('express');
const app = express();
const bodyParser = require("body-parser");
const path = require("path");
const mongoose = require("mongoose");
const dotenv = require("dotenv");
const cors = require('cors');
const multer = require('multer');

dotenv.config();
app.use(cors());
app.use(bodyParser.json());

// Configure multer storage
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

// Create multer instance
const upload = multer({ storage });

// Serve uploaded files statically
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

// Routes
const userRoute = require("./routers/userRoute");
const petRoute = require("./routers/petRoute");
const adoptionRoute = require("./routers/adoptionRoute");
const adoptionpetRoute = require("./routers/adoptedpetRoute");
const chatListRoute = require('./routers/chatlistRoute');
const chatRoute = require('./routers/chatRoute');

// Authentication routes
app.use("/users", userRoute);

// CRUD Pets routes
app.use("/pets", petRoute);

// Adoption form route
app.use("/adoption", adoptionRoute);

// CRUD Adopted Pet route
app.use("/adopted-pets", adoptionpetRoute);

// Add chat and message routes
app.use("/chats", chatListRoute);
app.use("/messages", chatRoute); 

const port = process.env.PORT || 5000;

// MongoDB connection
mongoose
  .connect(process.env.MONGO_URI)
  .then(() => console.log("MongoDB connected"))
  .catch((error) => console.log("MongoDB connection error: ", error));

app.listen(port, () => {
  console.log(`Server is running on port http://localhost:${port}`);
});

// Export upload for use in other modules
module.exports = { upload, app };
