const express = require("express");
const router =  express.Router();
const userController = require('../controller/userController');

router.get("/", userController.getUser);
router.get("/:id", userController.getUserById);
router.post("/", userController.createUser);
router.put("/:id", userController.updateUser);
pouter.delete("/:id", userController.deleteUser);

module.exports = router;