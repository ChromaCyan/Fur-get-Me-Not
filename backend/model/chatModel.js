const mongoose = require("mongoose");

const chatSchema = new mongoose.Schema({
   sender: {type: String, required: true}, 
   message: {type: String, required: true}, 
   timestamp: {type: date, default: Date.now}, 
});

const Chat = mongoose.model("Chat", chatSchema);
module.exports = Chat;