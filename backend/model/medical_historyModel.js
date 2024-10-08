const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const medicalHistorySchema = new mongoose.Schema({
  petId: { type: Schema.Types.ObjectId, ref: 'Pet', required: true },
  condition: {
    type: String,
    required: true,
  },
  diagnosisDate: {
    type: Date,
    required: true,
  },
  treatment: {
    type: String,
    required: true,
  },
  veterinarianName: {
    type: String,
  },
  clinicName: {
    type: String,
  },
  treatmentDate: {
    type: Date,
  },
  recoveryStatus: {
    type: String,
    enum: ['Recovered', 'Ongoing Treatment', 'Chronic'],
    required: true,
  },
  notes: {
    type: String,
  },
}, { timestamps: true });

module.exports = mongoose.model('MedicalHistory', medicalHistorySchema);
