const express = require("express");
const router = express.Router();
const petController = require('../controller/petController');
const { verifyToken, isAdoptee } = require('../middleware/authMiddleware');
const { uploadPetImage } = require('../middleware/uploadMiddleware'); 

// Use middleware to verify JWT for all pet routes
router.use(verifyToken);

router.get('/export-excel', petController.exportPets);

// Route for Adoptees to create a pet listing (Create)
router.post("/add-pet", isAdoptee, petController.createPet);

// Route for uploading a pet image
router.post('/upload-image', uploadPetImage, petController.uploadImage); 

// Route for Adoptees to update their pet listing (Update)
router.put("/:id", uploadPetImage, isAdoptee, petController.updatePet);

// Route for Adoptees to delete their pet listing (Delete)
router.delete("/:id", isAdoptee, petController.deletePet);

// Route for Adoptees to get their own pets (Read)
router.get("/my-pets", isAdoptee, petController.getPetsbyadoptee);

// Route for fetching a specific pet by ID
router.get("/:id", petController.getPetById);

// Route for fetching all pets available for adoption (Read)
router.get("/", petController.getPets);

module.exports = router;
