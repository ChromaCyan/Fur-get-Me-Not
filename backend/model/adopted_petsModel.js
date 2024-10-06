const mongoose = require("mongoose");

const adopted_petSchema = new mongoose.Schema({
    id: {type: String, required: true},
    name: {type: String, required: true},
    description: {type: String, required: true},
    breed: {type: String, required: true},
    age: {type: Number, required: true},
    height: {type: Number, required: true},
    petImageUrl: {type: String, required: true},
    medicalHistoryImageUrl: {type: String, required: true},
    specialCareInstructions: {type: String, required: true},
});
const AdoptedPet = mongoose.model("adopted_petSchema", adopted_petSchema);
module.exports = AdoptedPet;
