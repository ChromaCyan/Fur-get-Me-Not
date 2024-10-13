const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const adoptedPetSchema = new mongoose.Schema({
    name: { type: String, required: true },
    breed: { type: String, required: true },
    gender: { type: String, required: true },
    age: { type: Number, required: true },
    height: { type: Number, required: true }, 
    weight: { type: Number, required: true }, 
    petImageUrl: { type: String, required: true },
    description: { type: String, required: true },
    specialCareInstructions: { type: String },
    adopterId: { type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }, 
    adoptionDate: { type: Date, required: true }, 
    medicalHistory: {
        condition: { type: String, required: true },
        diagnosisDate: { type: Date, required: true },
        treatment: { type: String, required: true },
        veterinarianName: { type: String },
        clinicName: { type: String },
        treatmentDate: { type: Date },
        recoveryStatus: {
            type: String,
            enum: ['Recovered', 'Ongoing Treatment', 'Chronic'],
            required: true,
        },
        notes: { type: String },
    },
    vaccineHistory: {
        vaccineName: { type: String, required: true }, 
        vaccinationDate: { type: Date, required: true },
        nextDueDate: { type: Date },
        veterinarianName: { type: String },
        clinicName: { type: String },
        notes: { type: String },
    },
    status: { 
        type: String, 
        enum: ['Active', 'Archived'], 
        default: 'active'
    }
}, { timestamps: true });

const AdoptedPet = mongoose.model('AdoptedPet', adoptedPetSchema);

module.exports = AdoptedPet;
