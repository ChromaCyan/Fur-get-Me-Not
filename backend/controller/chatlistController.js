const Chat = require('../model/chat_list');
const Message = require('../model/chatModel');

// Get chat list for the logged-in user
exports.getChatListForUser = async (req, res) => {
  try {
    const { id: userId } = req.user;

    // Fetch all chats where the user is a participant
    const chats = await Chat.find({ participants: userId })
      .populate({
        path: 'participants',
        select: 'firstName lastName',
        match: { _id: { $ne: userId } },
      })
      .select('lastMessage updatedAt participants');

    // Format the chat list to return relevant information
    const chatList = chats.map(chat => {
      const otherUser = chat.participants[0];

      // Safely access otherUser properties and handle null cases
      const firstName = otherUser ? otherUser.firstName : 'Unknown First Name';
      const lastName = otherUser ? otherUser.lastName : 'Unknown Last Name';
      const fullName = `${firstName} ${lastName}`; // Safe concatenation

      return {
        chatId: chat._id,
        otherUser: {
          id: otherUser ? otherUser._id : null,
          fullName, 
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
