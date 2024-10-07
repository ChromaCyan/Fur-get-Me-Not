const express = require("express");
const router = express.Router();
const authController = require('../controller/authController');
const { verifyToken } = require('../middleware/authMiddleware');

// Routes that do not require token verification
router.post("/register", authController.createUser);
router.post("/login", authController.loginUser);

// Protected routes that require token verification
router.get("/", verifyToken, authController.getUser);
router.get("/profile/:id", verifyToken, authController.getUserById);
router.put("/profile/:id", verifyToken, authController.updateUser);
router.delete("/profile/:id", verifyToken, authController.deleteUser);

module.exports = router;
