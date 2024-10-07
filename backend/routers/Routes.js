const express = require("express");
const router =  express.Router();
const authController = require('../controller/authController');

router.get("/", authController.getUser);
router.get("/:id", authController.getUserById);
router.post("/register", authController.createUser);
router.post("/login", authController.loginUser);
router.put("/:id", authController.updateUser);
router.delete("/:id", authController.deleteUser);

module.exports = router;