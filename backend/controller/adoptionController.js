const AdoptionForm = require('../model/adoption_formModel');
const AdoptionStatus = require('../model/adoption_statusModel');
const AdoptionRequest = require('../model/adoption_requestModel');
const Pet = require('../model/petModel');
const AdoptedPet = require('../model/adopted_petsModel');

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
      petId,
      adoptionFormId: adoptionForm._id,
      adopteeId: pet.adopteeId,
      status: 'Pending',
      requestDate: Date.now(),
    });

    await adoptionRequest.save();

    // Create AdoptionStatus record
    const adoptionStatus = new AdoptionStatus({
      adoptionRequestId: adoptionRequest._id,
      adopterId: req.user.id,
      petId,
      adopteeId: pet.adopteeId,
      requestDate: Date.now(),
      status: 'Pending',
    });

    await adoptionStatus.save(); 

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
      .populate('adoptionRequestId') 
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
    const adoptionRequests = await AdoptionRequest.find({ adopteeId: req.user.id }) 
      .populate('adoptionFormId')
      .populate('petId') 
      .populate('adopterId'); 

    res.status(200).json(adoptionRequests);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption requests', error });
  }
};

// Function to get all adoption forms submitted to the adoptee
exports.getAdoptionFormsForAdoptee = async (req, res) => {
  try {
    const adoptionForms = await AdoptionForm.find({ adopterId: req.user.id })
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
  const { requestId, status } = req.body; 
  try {
    // Update the adoption request status directly
    const adoptionRequest = await AdoptionRequest.findByIdAndUpdate(requestId, { status }, { new: true });

    if (!adoptionRequest) {
      return res.status(404).json({ message: 'Adoption request not found' });
    }

    // Update the adoption status record associated with this request
    const updatedStatus = await AdoptionStatus.findOneAndUpdate(
      { adoptionRequestId: requestId }, 
      { status }, 
      { new: true }
    );

    // If the status is "Adoption Completed," transfer the pet
    if (status === 'Adoption Completed') {
      // Find the adoption request by ID and populate the relevant data
      const adoptionRequest = await AdoptionRequest.findById(requestId)
        .populate('petId')
        .populate('adopterId');

      if (!adoptionRequest) {
        return res.status(404).json({ message: 'Adoption request not found' });
      }

      // Transfer pet details to AdoptedPet model
      const pet = await Pet.findById(adoptionRequest.petId);
      const adoptedPet = new AdoptedPet({
        name: pet.name,
        breed: pet.breed,
        gender: pet.gender,
        age: pet.age,
        height: pet.height,
        weight: pet.weight,
        petImageUrl: pet.petImageUrl,
        description: pet.description,
        specialCareInstructions: pet.specialCareInstructions,
        adopterId: adoptionRequest.adopterId, // New owner
        adoptionDate: Date.now(), // Current date as adoption date
        status: 'Active',
      });

      await adoptedPet.save();

      // Remove the pet from the original adoption listing
      await Pet.findByIdAndDelete(pet._id); // Or mark as adopted using a flag
    }

    // Respond with success
    res.status(200).json({
      message: 'Adoption request and status updated successfully',
      updatedStatus
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error updating adoption request status', error: error.message });
  }
};
