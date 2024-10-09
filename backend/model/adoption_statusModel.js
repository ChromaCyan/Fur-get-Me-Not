const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const adoptionStatusSchema = new Schema({
  adoptionRequestId: { type: Schema.Types.ObjectId, ref: 'AdoptionRequest', required: true }, 
  adopterId: { type: Schema.Types.ObjectId, ref: 'User', required: true },
  adopteeId: {
    type: mongoose.Schema.Types.ObjectId,
    required: true, 
    ref: 'Adoptee'
  },
  petId: { type: Schema.Types.ObjectId, ref: 'Pet', required: true }, 
  requestDate: { type: Date, default: Date.now }, 
  status: { type: String, default: 'Pending' }, 
});

module.exports = mongoose.model('AdoptionStatus', adoptionStatusSchema);
