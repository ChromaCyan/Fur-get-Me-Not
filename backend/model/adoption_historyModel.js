const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const adoptionHistorySchema = new Schema({
  adoptionRequestId: { type: Schema.Types.ObjectId, ref: 'AdoptionRequest', required: true }, 
  petId: { type: Schema.Types.ObjectId, ref: 'Pet', required: true },  
  adopterId: { type: Schema.Types.ObjectId, ref: 'User', required: true },  
  adopteeId: { type: Schema.Types.ObjectId, ref: 'User', required: true },  
  adoptionDate: { type: Date, required: true },  
  status: { type: String, default: 'Completed' },
});

module.exports = mongoose.model('AdoptionHistory', adoptionHistorySchema);
