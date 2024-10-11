const Pet = require('../model/petModel');
const User = require('../model/userModel'); 

// Get all available pets (No restrictions, viewable to both Adoptees and Adopters)
exports.getPets = async (req, res) => {
  try {
    const pets = await Pet.find({ status: 'available' })
      .populate('adopteeId', 'firstName lastName');
    res.status(200).json(pets);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

// Get pets created by the logged-in Adoptee user
exports.getPetsbyadoptee = async (req, res) => {
  try {
    const { id } = req.user;
    const pets = await Pet.find({ adopteeId: id, status: 'available' })
      .populate('adopteeId', 'firstName lastName');
    res.status(200).json(pets);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
// Get a single pet by ID
exports.getPetById = async (req, res) => {
  try {
    const { id } = req.params; // Extract id from request parameters

    console.log('Request Body:', req.body);
    console.log('User ID:', req.user.id);

    // Fetch the pet using the id
    const pet = await Pet.findById(id).populate('adopteeId', 'firstName lastName');
    
    if (!pet || pet.status === 'adopted') { 
      return res.status(404).json({ message: 'Pet not found or has been adopted' });
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

    // Create new pet object with adopteeId and combined medical & vaccine history
    const newPet = new Pet({
      ...req.body,
      adopteeId: req.user.id,
      status: 'available'
    });

    console.log('New Pet Object:', newPet);

    const savedPet = await newPet.save();
    res.status(201).json(savedPet);
  } catch (error) {
    console.error('Error in createPet:', error.message); 
    res.status(500).json({ message: error.message });
  }
};

// Upload an image for a pet and update the pet's image URL
exports.uploadImage = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ message: 'No file uploaded' });
    }

    // Construct the image URL
    const filePath = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
    
    // Get the pet ID from the request body
    const { petId } = req.body; 

    // Update the pet's image URL in the database
    const updatedPet = await Pet.findByIdAndUpdate(
      petId,
      { petImageUrl: filePath }, // Update only the image URL
      { new: true } // Return the updated pet object
    );

    if (!updatedPet) {
      return res.status(404).json({ message: 'Pet not found' });
    }

    // Respond with the updated pet object
    res.status(200).json({ imageUrl: filePath, pet: updatedPet });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error uploading image', error });
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

    // Find the existing pet first
    const existingPet = await Pet.findById(id);
    if (!existingPet) {
      return res.status(404).json({ message: 'Pet not found' });
    }

    // Prepare updated data
    const updatedData = {
      ...existingPet.toObject(), // Convert existing pet document to an object
      ...req.body, // Merge with incoming data
    };

    // Check if a new image has been uploaded
    if (req.file) {
      const filePath = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
      updatedData.petImageUrl = filePath; 
    }

    // Update the pet in the database
    const updatedPet = await Pet.findByIdAndUpdate(id, updatedData, { new: true });
    
    if (!updatedPet) {
      return res.status(404).json({ message: 'Pet not found' });
    }
    
    // Respond with the updated pet object
    res.status(200).json(updatedPet);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};


// Update a pet's status to 'removed' (Adoptee Only)
exports.deletePet = async (req, res) => {
  try {
    const { role } = req.user;
    if (role !== 'adoptee') {
      return res.status(403).json({ message: 'Access denied. Only Adoptees can change pet listings.' });
    }

    const { id } = req.params;
    
    // Update the pet's status to 'removed'
    const updatedPet = await Pet.findByIdAndUpdate(
      id,
      { status: 'removed' }, // Change the status to 'removed'
      { new: true } // Return the updated document
    );

    if (!updatedPet) {
      return res.status(404).json({ message: 'Pet not found' });
    }

    res.status(200).json({ message: 'Pet status updated to removed successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
