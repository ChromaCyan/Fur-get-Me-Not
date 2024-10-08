const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const adoptionRequestSchema = new Schema({
  adopterId: { type: Schema.Types.ObjectId, ref: 'User', required: true }, 
  petId: { type: Schema.Types.ObjectId, ref: 'Pet', required: true }, 
  adoptionFormId: { type: Schema.Types.ObjectId, ref: 'AdoptionForm', required: true }, 
  adopteeId: { type: Schema.Types.ObjectId, ref: 'User', required: true }, 
  requestDate: { type: Date, default: Date.now },
  status: { type: String, default: 'pending' }, 
});

module.exports = mongoose.model('AdoptionRequest', adoptionRequestSchema);
