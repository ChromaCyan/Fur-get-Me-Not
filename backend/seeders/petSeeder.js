const mongoose = require('mongoose');
const Pet = require('../model/petModel');

const MONGO_URI = 'mongodb+srv://joaquingabrielcamangeg6:d863ZpS8ywoAhKpI@cluster0.yihls.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0'; // Replace with your MongoDB URI

// Connect to MongoDB
mongoose.connect(MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
.then(() => console.log('MongoDB connected'))
.catch(err => console.log('Error connecting to MongoDB:', err));

// Function to generate random pet data
const getRandomPetData = () => {
    const breeds = ['Dog', 'Cat'];
    const names = ['Odis', 'Fred', 'Bella', 'Max', 'Luna', 'Charlie', 'Milo'];
    const descriptions = [
        'Life is good.',
        'Brings smile to your face.',
        'Loves to play.',
        'Very affectionate.',
        'Enjoys long naps.',
    ];
    const genders = ['Male', 'Female'];
    const statusOptions = ['available', 'adopted'];

    return {
        name: names[Math.floor(Math.random() * names.length)],
        breed: breeds[Math.floor(Math.random() * breeds.length)],
        gender: genders[Math.floor(Math.random() * genders.length)],
        age: Math.floor(Math.random() * 15) + 1, // Random age between 1 and 15
        height: Math.floor(Math.random() * 50) + 20, // Random height between 20 and 70
        weight: Math.floor(Math.random() * 30) + 5, // Random weight between 5 and 35
        petImageUrl: 'http://example.com/image.jpg', // Use a placeholder image URL
        description: descriptions[Math.floor(Math.random() * descriptions.length)],
        specialCareInstructions: '',
        adopteeId: '67120fcff1cda7e97ccc855f', // Ensure this is a valid adoptee ID in your database
        medicalHistory: {
            condition: 'None',
            diagnosisDate: new Date(),
            treatment: 'None',
            veterinarianName: 'Dr. Smith',
            clinicName: 'Happy Paws Vet Clinic',
            treatmentDate: new Date(),
            recoveryStatus: 'Recovered',
            notes: 'No issues.',
        },
        vaccineHistory: {
            vaccineName: 'Rabies',
            vaccinationDate: new Date(),
            nextDueDate: new Date(new Date().setFullYear(new Date().getFullYear() + 1)),
            veterinarianName: 'Dr. Brown',
            clinicName: 'Healthy Pets Clinic',
            notes: 'Vaccinated on schedule.',
        },
        status: statusOptions[Math.floor(Math.random() * statusOptions.length)],
    };
};

// Seed the database with pet data
const seedPets = async (numPets) => {
    const petPromises = Array.from({ length: numPets }, () => {
        const petData = getRandomPetData();
        return new Pet(petData).save();
    });

    try {
        await Promise.all(petPromises);
        console.log(`${numPets} pets have been successfully added to the database.`);
    } catch (err) {
        console.error('Error seeding pets:', err);
    } finally {
        mongoose.connection.close();
    }
};

// Run the seeder
seedPets(80);
