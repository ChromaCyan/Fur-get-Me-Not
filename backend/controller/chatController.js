const Message = require('../model/chatModel');
const Chat = require('../model/chat_list');
const User = require('../model/userModel');

// Get messages between the logged-in user and a specific other user (adopter/adoptee)
exports.getMessagesForUser = async (req, res) => {
  try {
    const { id: userId } = req.user; 
    const { otherUserId } = req.params;

    const chat = await Chat.findOne({
      participants: { $all: [userId, otherUserId] }
    }).select('_id');

    if (!chat) {
      return res.status(200).json([]); 
    }

    const messages = await Message.find({ chatId: chat._id })
      .populate('senderId', 'firstName lastName profileImage')
      .sort('createdAt'); 

    const enrichedMessages = await Promise.all(messages.map(async (message) => {
      const sender = await User.findById(message.senderId).select('firstName lastName profileImage');
      const recipient = await User.findById(otherUserId).select('firstName lastName profileImage');

      return {
        ...message.toObject(),
        senderName: `${sender.firstName} ${sender.lastName}`,
        recipientName: `${recipient.firstName} ${recipient.lastName}`,
      };
    }));

    res.status(200).json(enrichedMessages);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};


// Send a new message or create a new chat if it doesn't exist
exports.sendMessage = async (req, res) => {
  try {
    const { content, otherUserId } = req.body;
    const { id: senderId } = req.user;

    let chat = await Chat.findOne({
      participants: { $all: [senderId, otherUserId] }
    });

    if (!chat) {
      chat = new Chat({
        participants: [senderId, otherUserId]
      });
      await chat.save(); 
    }

    const newMessage = new Message({
      chatId: chat._id,
      senderId,
      content,
    });

    await newMessage.save(); 

    chat.lastMessage = content;
    chat.updatedAt = Date.now();
    await chat.save();

    const sender = await User.findById(senderId).select('firstName lastName profileImage');
    const recipient = await User.findById(otherUserId).select('firstName lastName profileImage');

    res.status(200).json({
      chatId: chat._id, 
      message: {
        ...newMessage.toObject(),
        senderName: `${sender.firstName} ${sender.lastName}`,
        recipientName: `${recipient.firstName} ${recipient.lastName}`,
      }
    });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};