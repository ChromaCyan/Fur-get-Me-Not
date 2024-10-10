const Pet = require('../model/petModel');
const User = require('../model/userModel'); 

// Get all pets (No restrictions, viewable to both Adoptees and Adopters)
exports.getPets = async (req, res) => {
  try {
    // Populate the adoptee details (name) for each pet
    const pets = await Pet.find().populate('adopteeId', 'firstName lastName');
    res.status(200).json(pets);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get pets created by the logged-in Adoptee user
exports.getPetsbyadoptee = async (req, res) => {
  try {
    const { id } = req.user;

    // Populate the adoptee details (name) for each pet that belongs to the logged-in user
    const pets = await Pet.find({ adopteeId: id }).populate('adopteeId', 'firstName lastName');

    res.status(200).json(pets);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get a single pet by ID
exports.getPetById = async (req, res) => {
  try {
    const pet = await Pet.findById(req.params.id).populate('adopteeId'); 

    if (!pet) {
      return res.status(404).json({ message: 'Pet not found' });
    }

    res.status(200).json(pet);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving pet', error });
  }
};

// Create a new pet (Adoptee Only)
exports.createPet = async (req, res) => {
  try {
    const { role } = req.user;
    console.log('User in createPet:', req.user); 

    if (role !== 'adoptee') {
      return res.status(403).json({ message: 'Access denied. Only Adoptees can create pet listings.' });
    }

    // Create new pet object with adopteeId
    const newPet = new Pet({
      ...req.body,
      adopteeId: req.user.id
    });

    console.log('New Pet Object:', newPet);

    const savedPet = await newPet.save();
    res.status(201).json(savedPet);
  } catch (error) {
    console.error('Error in createPet:', error.message); 
    res.status(500).json({ message: error.message });
  }
};


// Add pet medical history
exports.addMedicalHistory = async (req, res) => {
    const { petId, conditions, medications, surgeries, allergies } = req.body;

    const medicalHistory = new MedicalHistory({
        petId,
        conditions,
        medications,
        surgeries,
        allergies,
    });

    try {
        await medicalHistory.save();
        res.status(201).json({ message: 'Medical history added successfully', medicalHistory });
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

// Add pet vaccine history
exports.addVaccineHistory = async (req, res) => {
    const { petId, vaccines, lastVaccinationDate } = req.body;

    const vaccineHistory = new VaccineHistory({
        petId,
        vaccines,
        lastVaccinationDate,
    });

    try {
        await vaccineHistory.save();
        res.status(201).json({ message: 'Vaccine history added successfully', vaccineHistory });
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

// Update a pet (Adoptee Only)
exports.updatePet = async (req, res) => {
  try {
    const { role } = req.user;
    if (role !== 'adoptee') {
      return res.status(403).json({ message: 'Access denied. Only Adoptees can update pet listings.' });
    }

    const { id } = req.params;
    const updatedPet = await Pet.findByIdAndUpdate(id, req.body, { new: true });
    if (!updatedPet) {
      return res.status(404).json({ message: 'Pet not found' });
    }
    res.status(200).json(updatedPet);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Delete a pet (Adoptee Only)
exports.deletePet = async (req, res) => {
  try {
    const { role } = req.user;
    if (role !== 'adoptee') {
      return res.status(403).json({ message: 'Access denied. Only Adoptees can delete pet listings.' });
    }

    const { id } = req.params;
    const deletedPet = await Pet.findByIdAndDelete(id);
    if (!deletedPet) {
      return res.status(404).json({ message: 'Pet not found' });
    }
    res.status(200).json({ message: 'Pet deleted successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
