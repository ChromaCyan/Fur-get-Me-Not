const AdoptionForm = require('../model/adoption_formModel');
const AdoptionStatus = require('../model/adoption_statusModel');
const AdoptionRequest = require('../model/adoption_requestModel');
const Pet = require('../model/petModel');
const AdoptedPet = require('../model/adopted_petsModel');
const AdoptionHistory = require('../model/adoption_historyModel');

// ------------------------- Adopter Functions here (10/15/2024) ------------------------- //

// Function to submit an adoption form and create an adoption request
exports.submitAdoptionForm = async (req, res) => {
  try {

    const params = req.body

    // Create new AdoptionForm
    const adoptionForm = new AdoptionForm({
      adopterId: params.user.id,
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

    await adoptionForm.save();

    const pet = await Pet.findById(petId);
    if (!pet) {
      return res.status(404).json({ message: 'Pet not found' });
    }

    if (!pet.adopteeId) {
      return res.status(400).json({ message: 'Adoptee ID is missing for this pet' });
    }

    const adoptionRequest = new AdoptionRequest({
      adopterId: req.user.id,
      petId,
      adoptionFormId: adoptionForm._id,
      adopteeId: pet.adopteeId,
      status: 'Pending',
      requestDate: Date.now(),
    });

    await adoptionRequest.save();

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

    const filteredStatuses = adoptionStatuses.filter(status => status.petId !== null);

    res.status(200).json(filteredStatuses);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption statuses', error });
  }
};

// ------------------------- Adoptee Functions below here (Updated this for adoption history: 10/20/2024) ------------------------- //

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
    const adoptionRequest = await AdoptionRequest.findById(requestId).populate('adoptionFormId');

    if (!adoptionRequest || !adoptionRequest.adoptionFormId) {
      return res.status(404).json({ message: 'Adoption request or form not found' });
    }

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

    const adoptionRequest = await AdoptionRequest.findByIdAndUpdate(requestId, { status }, { new: true });

    if (!adoptionRequest) {
      return res.status(404).json({ message: 'Adoption request not found' });
    }

    const updatedStatus = await AdoptionStatus.findOneAndUpdate(
      { adoptionRequestId: requestId }, 
      { status }, 
      { new: true }
    );

    if (status === 'Adoption Completed') {
      const adoptionRequest = await AdoptionRequest.findById(requestId)
        .populate('petId')
        .populate('adopterId');

      if (!adoptionRequest) {
        return res.status(404).json({ message: 'Adoption request not found' });
      }

      const pet = await Pet.findById(adoptionRequest.petId);
      if (!pet) {
        return res.status(404).json({ message: 'Pet not found' });
      }

      pet.status = 'adopted';
      await pet.save(); 

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
        medicalHistory: pet.medicalHistory, 
        vaccineHistory: pet.vaccineHistory, 
        adopterId: adoptionRequest.adopterId, 
        adoptionDate: Date.now(), 
        status: 'Active',
      });

      await adoptedPet.save();

      const adoptionHistory = new AdoptionHistory({
        adoptionRequestId: requestId,
        petId: pet._id,
        adopterId: adoptionRequest.adopterId,
        adopteeId: pet.adopteeId,
        adoptionDate: Date.now(),
        status: 'Completed',
      });
      await adoptionHistory.save();
    }

    res.status(200).json({
      message: 'Adoption request and status updated successfully',
      updatedStatus
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error updating adoption request status', error: error.message });
  }
};

// ------------------------- Adopter/Adopter function (Updated this for adoption history: 10/20/2024) ------------------------- //

// Get adoption history for a user (adopter/adoptee)
exports.getAdoptionHistoryForUser = async (req, res) => {
  try {
    const userId = req.user.id; 

    const adoptionHistories = await AdoptionHistory.find({
      $or: [
        { adopterId: userId },
        { adopteeId: userId },
      ],
    })
      .populate({
        path: 'petId',
        select: 'name breed age petImageUrl',
        match: { status: { $ne: 'removed' } }, 
      })
      .populate({
        path: 'adopterId',
        select: 'firstName lastName email address',
      })
      .populate({
        path: 'adopteeId',
        select: 'firstName lastName email address',
      });

    const filteredHistories = adoptionHistories.filter(history => history.petId !== null);

    res.status(200).json(filteredHistories);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adoption history', error });
  }
};