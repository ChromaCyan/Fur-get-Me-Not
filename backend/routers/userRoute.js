const express = require("express");
const router = express.Router();
const authController = require('../controller/authController');
const { verifyToken } = require('../middleware/authMiddleware');
const { uploadProfileImage } = require('../middleware/uploadMiddleware'); 

// Routes that do not require token verification
router.post("/register", uploadProfileImage, authController.createUser);
router.post("/login", authController.loginUser);

// Route for uploading profile image
router.post("/upload", uploadProfileImage, authController.uploadProfileImage);

// Protected routes that require token verification
router.get("/", verifyToken, authController.getUser);
router.get("/profile/:id", verifyToken, authController.getUserById);
router.put("/profile/:id", verifyToken, uploadProfileImage, authController.updateUser);
router.delete("/profile/:id", verifyToken, authController.deleteUser);

module.exports = router;
