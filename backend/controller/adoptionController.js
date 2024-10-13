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
    const adoptionStatuses = await AdoptionStatus.find({ adopterId: req.user.id, status: { $ne: 'Adoption Completed' } })
      .populate('adoptionRequestId')
      .populate({
        path: 'petId',
        match: { status: { $ne: 'removed' } }, 
      })
      .populate('adopteeId');

    // Filter out any adoption statuses where petId is null (meaning it was removed)
    const filteredStatuses = adoptionStatuses.filter(status => status.petId !== null);

    res.status(200).json(filteredStatuses);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption statuses', error });
  }
};

// ------------------------- Adoptee Functions ------------------------- //

// Function to get all adoption requests for an adoptee
exports.getAdoptionRequestsForAdoptee = async (req, res) => {
  try {
    const adoptionRequests = await AdoptionRequest.find({ adopteeId: req.user.id, status: { $ne: 'Adoption Completed' } })
      .populate('adoptionFormId')
      .populate({
        path: 'petId',
        match: { status: { $ne: 'removed' } }
      })
      .populate({
        path: 'adopterId',
        select: 'firstName lastName email address'
      });

    const filteredRequests = adoptionRequests.filter(request => request.petId !== null);
    res.status(200).json(filteredRequests);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption requests', error });
  }
};



// Function to get the adoption form for a specific adoption request
exports.getAdoptionFormByRequestId = async (req, res) => {
  const { requestId } = req.params;
  try {
    // Find the adoption request by ID
    const adoptionRequest = await AdoptionRequest.findById(requestId).populate('adoptionFormId');

    if (!adoptionRequest || !adoptionRequest.adoptionFormId) {
      return res.status(404).json({ message: 'Adoption request or form not found' });
    }

    // Return the adoption form details
    res.status(200).json(adoptionRequest.adoptionFormId);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption form', error });
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

    // If the status is "Adoption Completed," update the pet's status
    if (status === 'Adoption Completed') {
      // Find the adoption request by ID and populate the relevant data
      const adoptionRequest = await AdoptionRequest.findById(requestId)
        .populate('petId')
        .populate('adopterId');

      if (!adoptionRequest) {
        return res.status(404).json({ message: 'Adoption request not found' });
      }

      // Find the pet to update its status
      const pet = await Pet.findById(adoptionRequest.petId);
      if (!pet) {
        return res.status(404).json({ message: 'Pet not found' });
      }

      // Update the pet's status to "adopted"
      pet.status = 'adopted';
      await pet.save(); // Save the updated pet

      // Optionally, you can create an entry in the AdoptedPet model if needed
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
        adopterId: adoptionRequest.adopterId, 
        adoptionDate: Date.now(), 
        status: 'Active',
      });

      await adoptedPet.save();
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
