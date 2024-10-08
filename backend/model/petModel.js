const mongoose = require('mongoose');
const Schema = mongoose.Schema;

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
    adopteeId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }, 
});

module.exports = mongoose.model('Pet', petSchema);
