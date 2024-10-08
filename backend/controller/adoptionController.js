// controllers/adoptionController.js
const AdoptionForm = require('../model/adoption_formModel');
const AdoptionStatus = require('../model/adoption_statusModel');
const AdoptionRequest = require('../model/adoption_requestModel');
const Pet = require('../model/petModel'); 

// ------------------------- Adopter Functions ------------------------- //

// Function to submit an adoption form and create an adoption request
exports.submitAdoptionForm = async (req, res) => {
  try {
    const {
      petId, fullName, email, phone, address, city, zipCode, residenceType,
      ownRent, landlordAllowsPets, ownedPetsBefore, petTypesOwned, petPreference,
      preferredSize, agePreference, hoursAlone, activityLevel, childrenAges,
      carePlan, whatIfNoLongerKeep, longTermCommitment
    } = req.body;

    // Create new AdoptionForm
    const adoptionForm = new AdoptionForm({
      adopterId: req.user.id,
      petId,
      fullName,
      email,
      phone,
      address,
      city,
      zipCode,
      residenceType,
      ownRent,
      landlordAllowsPets,
      ownedPetsBefore,
      petTypesOwned,
      petPreference,
      preferredSize,
      agePreference,
      hoursAlone,
      activityLevel,
      childrenAges,
      carePlan,
      whatIfNoLongerKeep,
      longTermCommitment,
    });

    // Save form to the database
    await adoptionForm.save();

    // Get the pet to find the adopteeId
    const pet = await Pet.findById(petId);
    if (!pet) {
      return res.status(404).json({ message: 'Pet not found' });
    }

    // Ensure adopteeId is defined
    if (!pet.adopteeId) {
      return res.status(400).json({ message: 'Adoptee ID is missing for this pet' });
    }

    // Create AdoptionRequest record
    const adoptionRequest = new AdoptionRequest({
      adopterId: req.user.id,
      petId: petId,
      adoptionFormId: adoptionForm._id,
      adopteeId: pet.adopteeId,
      status: 'pending',
      requestDate: Date.now(),
    });

    await adoptionRequest.save();

    // Create AdoptionStatus record
    const adoptionStatus = new AdoptionStatus({
      adoptionRequestId: adoptionRequest._id,
      adopterId: req.user.id,
      petId: petId,
      requestDate: Date.now(),
      status: 'pending',
    });

    await adoptionStatus.save(); // Save the adoption status

    return res.status(201).json({ message: 'Adoption request submitted successfully' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ message: 'Failed to submit adoption request' });
  }
};



// Function to get adoption statuses for an adopter
exports.getAdoptionStatusesForAdopter = async (req, res) => {
  try {
    const adoptionStatuses = await AdoptionStatus.find({ adopterId: req.user.id })
      .populate('adoptionRequestId') // Link adoption request
      .populate('petId')
      .populate('adopteeId');

    res.status(200).json(adoptionStatuses);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption statuses', error });
  }
};

// ------------------------- Adoptee Functions ------------------------- //

// Function to get all adoption requests for an adoptee
exports.getAdoptionRequestsForAdoptee = async (req, res) => {
  try {
    const adoptionRequests = await AdoptionRequest.find({ adopteeId: req.user.id }) // Filter by adoptee ID
      .populate('adoptionFormId') // Populating the adoption form
      .populate('petId') // Populating the pet
      .populate('adopterId'); // Populating the adopter

    res.status(200).json(adoptionRequests);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption requests', error });
  }
};

// Function to get all adoption forms submitted to the adoptee
exports.getAdoptionFormsForAdoptee = async (req, res) => {
  try {
    const adoptionForms = await AdoptionForm.find({ /* Filter by adoptee ID */ })
      .populate('adopterId') // Assuming you want adopter details
      .populate('petId');

    res.status(200).json(adoptionForms);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption forms', error });
  }
};

// Function to update the status of an adoption request
exports.updateAdoptionStatus = async (req, res) => {
  const { requestId, status } = req.body; // Expect requestId and new status in the request body
  try {
    // Update the adoption request status
    const adoptionRequest = await AdoptionRequest.findByIdAndUpdate(requestId, { status }, { new: true });

    if (!adoptionRequest) {
      return res.status(404).json({ message: 'Adoption request not found' });
    }

    // Update the adoption status record associated with this request
    const adoptionStatus = await AdoptionStatus.findOneAndUpdate(
      { adoptionRequestId: requestId }, // Find the associated adoption status by request ID
      { status }, // Update the status
      { new: true } // Return the updated record
    );

    // Check if the adoption status was found and updated
    if (!adoptionStatus) {
      return res.status(404).json({ message: 'Adoption status not found' });
    }

    res.status(200).json({
      message: 'Adoption request and status updated successfully',
      adoptionRequest,
      adoptionStatus
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error updating adoption request status', error });
  }
};
