const mongoose = require('mongoose');

const petSchema = new mongoose.Schema({
    name: { type: String, required: true },
    breed: { type: String, required: true },
    gender: { type: String, required: true },
    age: { type: Number, required: true },
    height: { type: Number, required: true },
    weight: { type: Number, required: true },
    petImageUrl: { type: String, required: true },
    description: { type: String, required: true },
    specialCareInstructions: { type: String },
});

module.exports = mongoose.model('Pet', petSchema);
