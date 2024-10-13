const express = require('express');
const router = express.Router();
const { verifyToken } = require('../middleware/authMiddleware');
const messageController = require('../controller/chatController');

// Get messages between the logged-in user and a specific user (otherUserId)
router.get('/:otherUserId', verifyToken, messageController.getMessagesForUser); 

// Send a new message to a specific user (otherUserId)
router.post('/new-message', verifyToken, messageController.sendMessage);

module.exports = router;
