const express = require("express");
const router =  express.Router();
const authController = require('../controller/authController');

router.get("/", authController.getUser);
router.get("/:id", authController.getUserById);
router.post("/", authController.createUser);
router.put("/:id", authController.updateUser);
router.delete("/:id", authController.deleteUser);

module.exports = router;