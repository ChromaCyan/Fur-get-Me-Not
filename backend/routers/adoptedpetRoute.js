const express = require("express");
const router = express.Router();
const adoptedPetController = require('../controller/adoptedpetController');
const { verifyToken, isAdopter } = require('../middleware/authMiddleware');

// Use middleware to verify JWT for all adopted pet routes
router.use(verifyToken);

// Route for retrieving all adopted pets
router.get("/", adoptedPetController.getAllAdoptedPets);

// Route for retrieving a specific adopted pet by ID
router.get("/:id", adoptedPetController.getAdoptedPetById);

// Route for archiving an adopted pet (soft delete)
router.put("/:id/archive", isAdopter, adoptedPetController.archiveAdoptedPet); 

// Route for updating an adopted pet's details (excluding status)
router.put("/:id", adoptedPetController.updateAdoptedPet);

module.exports = router;
