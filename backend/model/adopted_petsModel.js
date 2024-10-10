const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const adoptedPetSchema = new mongoose.Schema({
  name: String,
  breed: String,
  gender: String,
  age: Number,
  height: String,
  weight: String,
  petImageUrl: String,
  description: String,
  specialCareInstructions: String,
  adopterId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
  adoptionDate: Date,
  status: { type: String, default: 'active' } // Add status field (active, inactive, archived)
});

const AdoptedPet = mongoose.model('AdoptedPet', adoptedPetSchema);

module.exports = AdoptedPet;
