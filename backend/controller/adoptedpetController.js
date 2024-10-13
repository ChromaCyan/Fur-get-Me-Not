const AdoptedPet = require('../model/adopted_petsModel');

// Function to retrieve all adopted pets
exports.getAllAdoptedPets = async (req, res) => {
  try {
    const adoptedPets = await AdoptedPet.find({ status: 'Active' });
    res.status(200).json(adoptedPets);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adopted pets', error });
  }
};


// Function to retrieve all adopted pets by the logged-in user
exports.getAdoptedPetsByUser = async (req, res) => {
  try {
    const { id } = req.user; // Assumes req.user contains the logged-in user information

    // Fetch pets where adopterId matches the logged-in user's ID and the status is 'active'
    const adoptedPets = await AdoptedPet.find({ adopterId: id, status: 'Active' })
      .populate('adopterId', 'firstName lastName'); // Populate adopter details if needed

    // Return the found pets
    res.status(200).json(adoptedPets);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adopted pets for the user', error });
  }
};

// Function to get a specific adopted pet by ID
exports.getAdoptedPetById = async (req, res) => {
  try {
    const adoptedPet = await AdoptedPet.findById(req.params.id);
    if (!adoptedPet || adoptedPet.status === 'archived') {
      return res.status(404).json({ message: 'Adopted pet not found or archived' });
    }
    res.status(200).json(adoptedPet);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adopted pet', error });
  }
};

// Function to soft delete (archive) an adopted pet
exports.archiveAdoptedPet = async (req, res) => {
  try {
    const adoptedPet = await AdoptedPet.findById(req.params.id);
    if (!adoptedPet) {
      return res.status(404).json({ message: 'Adopted pet not found' });
    }

    adoptedPet.status = 'Archived'; 
    await adoptedPet.save();

    res.status(200).json({ message: 'Adopted pet archived successfully' });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error archiving adopted pet', error });
  }
};

// Function to update an adopted pet (e.g., for updates not involving status)
exports.updateAdoptedPet = async (req, res) => {
  const { id } = req.params;
  const updatedData = req.body;

  try {
    const adoptedPet = await AdoptedPet.findById(id);
    if (!adoptedPet || adoptedPet.status === 'Archived') {
      return res.status(404).json({ message: 'Adopted pet not found or archived' });
    }

    Object.assign(adoptedPet, updatedData); 
    await adoptedPet.save();

    res.status(200).json({ message: 'Adopted pet updated successfully', adoptedPet });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error updating adopted pet', error });
  }
};
