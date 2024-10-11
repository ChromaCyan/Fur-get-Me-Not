const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middleware/authMiddleware');
const chatController = require('../controller/chatlistController');

// Get chat list for the logged-in user
router.get('/chat-list', verifyToken, chatController.getChatListForUser);

module.exports = router;
