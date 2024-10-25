const Pet = require('../model/petModel');
const User = require('../model/userModel'); 
const ExcelJS = require('exceljs');
const path = require('path');
const fs = require('fs');

// Export the entire Pet table as an Excel file
exports.exportPets = async (req, res) => {
  try {
    // Fetch all pets from the database
    const pets = await Pet.find();

    // Create a new workbook and worksheet
    const workbook = new ExcelJS.Workbook();
    const worksheet = workbook.addWorksheet('Pet Table');

    // Define columns for the worksheet
    const columns = [
      { header: 'Name', key: 'name', width: 20 },
      { header: 'Breed', key: 'breed', width: 20 },
      { header: 'Gender', key: 'gender', width: 10 },
      { header: 'Age', key: 'age', width: 10 },
      { header: 'Height', key: 'height', width: 10 },
      { header: 'Weight', key: 'weight', width: 10 },
      { header: 'Image URL', key: 'petImageUrl', width: 40 },
      { header: 'Description', key: 'description', width: 30 },
      { header: 'Special Care Instructions', key: 'specialCareInstructions', width: 30 },
      { header: 'Adoptee ID', key: 'adopteeId', width: 20 },
      { header: 'Medical Condition', key: 'medicalCondition', width: 20 },
      { header: 'Diagnosis Date', key: 'diagnosisDate', width: 20 },
      { header: 'Treatment', key: 'treatment', width: 20 },
      { header: 'Veterinarian Name', key: 'veterinarianName', width: 20 },
      { header: 'Clinic Name', key: 'clinicName', width: 20 },
      { header: 'Treatment Date', key: 'treatmentDate', width: 20 },
      { header: 'Recovery Status', key: 'recoveryStatus', width: 20 },
      { header: 'Vaccine Name', key: 'vaccineName', width: 20 },
      { header: 'Vaccination Date', key: 'vaccinationDate', width: 20 },
      { header: 'Next Due Date', key: 'nextDueDate', width: 20 },
      { header: 'Vaccine Veterinarian Name', key: 'vaccineVeterinarianName', width: 20 },
      { header: 'Vaccine Clinic Name', key: 'vaccineClinicName', width: 20 },
    ];

    // Add columns to the worksheet
    worksheet.columns = columns;

    // Add each pet as a new row in the worksheet
    pets.forEach((pet) => {
      worksheet.addRow({
        name: pet.name,
        breed: pet.breed,
        gender: pet.gender,
        age: pet.age,
        height: pet.height,
        weight: pet.weight,
        petImageUrl: pet.petImageUrl,
        description: pet.description,
        specialCareInstructions: pet.specialCareInstructions,
        adopteeId: pet.adopteeId,
        medicalCondition: pet.medicalHistory ? pet.medicalHistory.condition : '',
        diagnosisDate: pet.medicalHistory ? pet.medicalHistory.diagnosisDate : '',
        treatment: pet.medicalHistory ? pet.medicalHistory.treatment : '',
        veterinarianName: pet.medicalHistory ? pet.medicalHistory.veterinarianName : '',
        clinicName: pet.medicalHistory ? pet.medicalHistory.clinicName : '',
        treatmentDate: pet.medicalHistory ? pet.medicalHistory.treatmentDate : '',
        recoveryStatus: pet.medicalHistory ? pet.medicalHistory.recoveryStatus : '',
        vaccineName: pet.vaccineHistory ? pet.vaccineHistory.vaccineName : '',
        vaccinationDate: pet.vaccineHistory ? pet.vaccineHistory.vaccinationDate : '',
        nextDueDate: pet.vaccineHistory ? pet.vaccineHistory.nextDueDate : '',
        vaccineVeterinarianName: pet.vaccineHistory ? pet.vaccineHistory.veterinarianName : '',
        vaccineClinicName: pet.vaccineHistory ? pet.vaccineHistory.clinicName : '',
      });
    });

    // Write the buffer to an Excel file
    const buffer = await workbook.xlsx.writeBuffer();

    // Set response headers to trigger download
    res.setHeader('Content-Disposition', 'attachment; filename=pet_table.xlsx');
    res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
    res.setHeader('Content-Length', buffer.length);

    // Send the buffer as the response
    res.status(200).send(buffer);
  } catch (error) {
    console.error('Error exporting pet table:', error);
    res.status(500).json({ message: 'Failed to export pet table', error: error.message });
  }
};

// Get all available pets (No restrictions, viewable to both Adoptees and Adopters)
exports.getPets = async (req, res) => {
  try {
    const pets = await Pet.find({ status: 'available' })
      .populate('adopteeId', 'firstName lastName profileImage');
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
      .populate('adopteeId', 'firstName lastName profileImage');
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
    const pet = await Pet.findById(id).populate('adopteeId', 'firstName lastName profileImage');
    
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
    const newPetData = {
      ...req.body,
      adopteeId: req.user.id,
      status: 'available',
    };

    // If an image file was uploaded, construct the image URL
    if (req.file) {
      const filePath = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
      newPetData.petImageUrl = filePath; // Add image URL to new pet data
    }

    const newPet = new Pet(newPetData);
    console.log('New Pet Object:', newPet);

    const savedPet = await newPet.save();
    res.status(201).json(savedPet);
  } catch (error) {
    console.error('Error in createPet:', error.message); 
    res.status(500).json({ message: error.message });
  }
};

// Upload an image for a pet
exports.uploadImage = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ message: 'No file uploaded' });
    }

    // Construct the image URL
    const filePath = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;

    // Respond with the image URL
    res.status(200).json({ imageUrl: filePath });
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
      ...existingPet.toObject(),
      ...req.body, 
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
      { status: 'removed' },
      { new: true } 
    );

    if (!updatedPet) {
      return res.status(404).json({ message: 'Pet not found' });
    }

    res.status(200).json({ message: 'Pet status updated to removed successfully' });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};
