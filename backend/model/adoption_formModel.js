const mongoose = require('mongoose');

const adoptionFormSchema = new mongoose.Schema({
  adopterId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true },
  petId: { type: mongoose.Schema.Types.ObjectId, ref: 'Pet', required: true },
  fullName: { type: String, required: true },
  email: { type: String, required: true },
  phone: { type: String, required: true },
  address: { type: String, required: true },
  city: { type: String, required: true },
  zipCode: { type: String, required: true },
  residenceType: { type: String, required: true },
  ownRent: { type: String, required: true },
  landlordAllowsPets: { type: Boolean, required: true },
  ownedPetsBefore: { type: Boolean, required: true },
  petTypesOwned: { type: [String], required: true },
  petPreference: { type: String, required: true },
  preferredSize: { type: String, required: true },
  agePreference: { type: String, required: true },
  hoursAlone: { type: Number, required: true },
  activityLevel: { type: String, required: true },
  childrenAges: { type: [Number], required: true },
  carePlan: { type: String, required: true },
  whatIfNoLongerKeep: { type: String, required: true },
  longTermCommitment: { type: Boolean, required: true },
});

const AdoptionForm = mongoose.model('AdoptionForm', adoptionFormSchema);
module.exports = AdoptionForm;
