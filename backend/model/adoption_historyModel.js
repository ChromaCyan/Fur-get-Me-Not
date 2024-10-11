const mongoose = require('mongoose');

const adoptionHistorySchema = new mongoose.Schema({
  name: String,
  breed: String,
  gender: String,
  age: Number,
  height: Number,
  weight: Number,
  petImageUrl: String,
  description: String,
  specialCareInstructions: String,
  adopterId: { type: mongoose.Schema.Types.ObjectId, ref: 'User' }, // Reference to adopter
  adoptionDate: { type: Date, default: Date.now },
  status: { type: String, default: 'Adopted' } // Can be 'Adopted' or other statuses
});

const AdoptionHistory = mongoose.model('AdoptionHistory', adoptionHistorySchema);
module.exports = AdoptionHistory;
