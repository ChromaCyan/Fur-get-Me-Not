const mongoose = require("mongoose");

const chat_listSchema = new mongoose.Schema({
    name: {type: String, required: true},
    lastMessage: {type: String, required: true},
    profilePicture: {type: String, required: true},
    timestamp: {type: DateTime, default: Date.now},
});

const ChatList = mongoose.model("ChatList", chat_listSchema);
module.exports = ChatList;