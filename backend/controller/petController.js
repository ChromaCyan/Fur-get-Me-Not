const Pet = require("../model/petModel");

//GETS PET DATA
exports.getPet = async (req, res) => {
    try {
        const pet = await User.find();
        res.status(200).json(pet)
    } catch (error) {
         res.status(500).json({message: error.message});
    }
}

//GETS PET DATA BY ID
exports.getPet = async (req, res) => {
    try {
      const pets = await Pet.find(); // Use Pet instead of User
      res.status(200).json(pets);
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  };

//CREATE PET DATA
exports.createPet = async (req, res) => {
    console.log(req.body);
    const{name, description, breed, age, height, petImageUrl, medicalHistoryImageUrl, specialCareInstructions} = req.body;

    console.log("========== PET Profile ==========");
    console.log("First Name:", name);
    console.log("Description:", description);
    console.log("Age:", age);
    console.log("Height:", height);
    console.log("petImageUrl:", petImageUrl);
    console.log("medicalHistoryImageUrl:", medicalHistoryImageUrl);
    console.log("specialCareInstructions:", specialCareInstructions);

    try {
        const newPet = new Pet({
            name,
            description,
            breed,
            age,
            height,
            petImageUrl,
            medicalHistoryImageUrl,
            specialCareInstructions,
        });
        await newPet.save();
        res.status(201).json(newPet)
    } catch (error) {
        res.status(400).json({message: error.message})
    }
};

//UPDATE PET DATA
exports.updatePet = async (req, res) => {
    const {id} = req.params;
    const{
        name, description, breed, age, height,
        petImageUrl, medicalHistoryImageUrl, specialCareInstructions
    } = req.body;

    try {
        const updatedPet = await Pet.findByIdAndUpdate(
            id,
            {
                name, description, breed, age, height,
                petImageUrl, medicalHistoryImageUrl, specialCareInstructions
            },
            {new: true}
        );
        res.status(200).json({updatedPet});
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};

//DELETE PET DATA
exports.deletePet = async (req, res) => {
    const { id } = req.params;
    try {
      const pet = await Pet.findByIdAndDelete(id);
      if (!pet) {
        return res.status(404).json({ message: "Pet not found" });
      }
      res.status(204).end(); // Successfully deleted
    } catch (error) {
      res.status(500).json({ message: error.message });
    }
  };
  