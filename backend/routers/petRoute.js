// routes/petRoutes.js

const express = require("express");
const router = express.Router();
const petController = require('../controller/petController');
const { verifyToken, isAdoptee } = require('../middleware/authMiddleware');

// Use middleware to verify JWT for all pet routes
router.use(verifyToken);

// Route for Adoptees to create a pet listing (Create)
router.post("/add_pet", isAdoptee, petController.createPet);

// Route for Adoptees to adding medical history (Create)
router.post("/add_medical", isAdoptee, petController.addMedicalHistory);

// Route for Adoptees to adding vaccine history (Create)
router.post("/add_vaccine", isAdoptee, petController.addVaccineHistory);

// Route for Adoptees to update their pet listing (Update)
router.put("/:id", isAdoptee, petController.updatePet);

// Route for Adoptees to delete their pet listing (Delete)
router.delete("/:id", isAdoptee, petController.deletePet);

// Route for fetching all pets available for adoption (Read)
router.get("/", petController.getPets); // This is open to all users

// Route for fetching a specific pet by ID
router.get("/:id", petController.getPetById);

module.exports = router;
