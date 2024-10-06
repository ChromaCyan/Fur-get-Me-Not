const express = require("express");
const router =  express.Router();
const adopterController = require('../controller/authController');

router.get("/", adopterController.getUser);
router.get("/:id", adopterController.getUserById);
router.post("/", adopterController.createUser);
router.put("/:id", adopterController.updateUser);
router.delete("/:id", adopterController.deleteUser);

module.exports = router;