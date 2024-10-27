const Chat = require('../model/chat_list');
const Message = require('../model/chatModel');
const User = require('../model/userModel');

// Get chat list for the logged-in user
exports.getChatListForUser = async (req, res) => {
  try {
    const { id: userId } = req.user;

    const chats = await Chat.find({ participants: userId })
      .populate({
        path: 'participants',
        select: 'firstName lastName profileImage',
        match: { _id: { $ne: userId } },
      })
      .select('lastMessage updatedAt participants');

    const chatList = chats.map(chat => {
      const otherUser = chat.participants[0];

      const firstName = otherUser ? otherUser.firstName : 'Unknown First Name';
      const lastName = otherUser ? otherUser.lastName : 'Unknown Last Name';
      const fullName = `${firstName} ${lastName}`; 
      const profileImage = otherUser ? otherUser.profileImage : null;

      return {
        chatId: chat._id,
        otherUser: {
          id: otherUser ? otherUser._id : null,
          fullName, 
          profileImage,
        },
        lastMessage: chat.lastMessage,
        updatedAt: chat.updatedAt,
      };
    });

    res.status(200).json(chatList);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
