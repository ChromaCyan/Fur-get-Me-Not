const express = require('express');
const {
  submitAdoptionForm,
  getAdoptionStatusesForAdopter,
  getAdoptionRequestsForAdoptee,
  getAdoptionFormsForAdoptee,
  updateAdoptionStatus
} = require('../controller/adoptionController');

const { verifyToken, isAdopter, isAdoptee } = require('../middleware/authMiddleware');

const router = express.Router();

// ------------------------- Adopter Routes ------------------------- //

// Route for submitting an adoption form
router.post('/adoption-form', verifyToken, isAdopter, submitAdoptionForm);

// Route for getting adoption statuses for the logged-in adopter
router.get('/adoption-status', verifyToken, isAdopter, getAdoptionStatusesForAdopter);

// ------------------------- Adoptee Routes ------------------------- //

// Route for getting all adoption requests for the logged-in adoptee
router.get('/adoption-request', verifyToken, isAdoptee, getAdoptionRequestsForAdoptee);

// Route for getting all adoption forms submitted to the logged-in adoptee
router.get('/adoption-forms', verifyToken, isAdoptee, getAdoptionFormsForAdoptee);

// Route for updating the status of an adoption request
router.put('/update-status', verifyToken, isAdoptee, updateAdoptionStatus);

module.exports = router;
