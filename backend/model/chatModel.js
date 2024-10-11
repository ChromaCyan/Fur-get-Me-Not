const mongoose = require("mongoose");

const messageSchema = new mongoose.Schema({
  chatId: { type: mongoose.Schema.Types.ObjectId, ref: 'Chat' }, 
  senderId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  content: { type: String }, 
  timestamp: { type: Date, default: Date.now } 
});

module.exports = mongoose.model('Message', messageSchema);
