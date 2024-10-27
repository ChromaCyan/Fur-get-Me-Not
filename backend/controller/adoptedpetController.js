const AdoptedPet = require('../model/adopted_petsModel');

// Get all adopted pets (For postman testing to display all adopted pets from all users)
exports.getAllAdoptedPets = async (req, res) => {
  try {
    const adoptedPets = await AdoptedPet.find({ status: 'Active' });
    res.status(200).json(adoptedPets);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adopted pets', error });
  }
};


// Get adopted pets based on logged-in user
exports.getAdoptedPetsByUser = async (req, res) => {
  try {
    const { id } = req.user; 

    const adoptedPets = await AdoptedPet.find({ adopterId: id, status: 'Active' })
      .populate('adopterId', 'firstName lastName'); 

    res.status(200).json(adoptedPets);
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error retrieving adopted pets for the user', error });
  }
};

// Get adopted pet by id
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

// This part has removed since you have to keep the pet you adopted {no takebakes lmao} (Delete adopted pet)
// exports.archiveAdoptedPet = async (req, res) => {
//   try {
//     const adoptedPet = await AdoptedPet.findById(req.params.id);
//     if (!adoptedPet) {
//       return res.status(404).json({ message: 'Adopted pet not found' });
//     }

//     adoptedPet.status = 'Archived'; 
//     await adoptedPet.save();

//     res.status(200).json({ message: 'Adopted pet archived successfully' });
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ message: 'Error archiving adopted pet', error });
//   }
// };

// This part has removed since you have to respect the pet data you got from adoptee (update adopted pet)
// exports.updateAdoptedPet = async (req, res) => {
//   const { id } = req.params;
//   const updatedData = req.body;

//   try {
//     const adoptedPet = await AdoptedPet.findById(id);
//     if (!adoptedPet || adoptedPet.status === 'Archived') {
//       return res.status(404).json({ message: 'Adopted pet not found or archived' });
//     }

//     Object.assign(adoptedPet, updatedData); 
//     await adoptedPet.save();

//     res.status(200).json({ message: 'Adopted pet updated successfully', adoptedPet });
//   } catch (error) {
//     console.error(error);
//     res.status(500).json({ message: 'Error updating adopted pet', error });
//   }
// };
