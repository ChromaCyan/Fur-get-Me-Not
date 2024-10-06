const mongoose = require("mongoose");

const petSchema = new mongoose.Schema({
    id: {type: String, required: true},
    name: {type: String, required: true},
    petType: {type: String, required: true},
    description: {type: String, required: true},
    breed: {type: String, required: true},
    age: {type: Number, required: true},
    height: {type: Number, required: true},
    petImageUrl: {type: String, required: true},
    medicalHistoryImageUrl: {type: String, required: true},
    specialCareInstructions: {type: String, required: true},
});

const Pet =  mongoose.model("Pet", petSchema);
module.exports = Pet;