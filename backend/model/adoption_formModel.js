const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const adoptionFormSchema = new Schema({
  adopterId: { type: Schema.Types.ObjectId, ref: 'User', required: true }, // References the user adopting the pet
  petId: { type: Schema.Types.ObjectId, ref: 'Pet', required: true }, // References the pet being adopted
  message: { type: String, default: '' }, // Optional message from the adopter
  status: { type: String, enum: ['pending', 'approved', 'rejected'], default: 'pending' }, // Status of the adoption
  comments: { type: String, default: '' }, // Optional comments by admin/reviewer
  createdAt: { type: Date, default: Date.now },
  updatedAt: { type: Date },
});

module.exports = mongoose.model('AdoptionForm', adoptionFormSchema);
