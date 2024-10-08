const express = require("express");
const router = express.Router();
const petController = require('../controller/petController');
const { verifyToken, isAdoptee } = require('../middleware/authMiddleware');

// Use middleware to verify JWT for all pet routes
router.use(verifyToken);

// Route for Adoptees to create a pet listing (Create)
router.post("/add_pet", isAdoptee, petController.createPet);

// Route for Adoptees to update their pet listing (Update)
router.put("/:id", isAdoptee, petController.updatePet);

// Route for Adoptees to delete their pet listing (Delete)
router.delete("/:id", isAdoptee, petController.deletePet);

// Route for Adoptees to get their own pets (Read)
router.get("/my_pets", isAdoptee, petController.getPetsbyadoptee);

// Route for fetching a specific pet by ID
router.get("/:id", petController.getPetById);

// Route for fetching all pets available for adoption (Read)
// This route can be kept for any general pet listings if needed
router.get("/", petController.getPets);

// Route for Adoptees to add medical history (Create)
router.post("/add_medical", isAdoptee, petController.addMedicalHistory);

// Route for Adoptees to add vaccine history (Create)
router.post("/add_vaccine", isAdoptee, petController.addVaccineHistory);

module.exports = router;
