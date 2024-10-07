const mongoose = require('mongoose');

const vaccineHistorySchema = new mongoose.Schema({
  petId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Pet',
    required: true,
  },
  vaccineName: {
    type: String,
    required: true, // e.g., "Rabies"
  },
  vaccinationDate: {
    type: Date,
    required: true,
  },
  nextDueDate: {
    type: Date,
  },
  veterinarianName: {
    type: String,
  },
  clinicName: {
    type: String,
  },
  notes: {
    type: String,
  },
}, { timestamps: true });

module.exports = mongoose.model('VaccineHistory', vaccineHistorySchema);
