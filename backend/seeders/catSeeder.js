const mongoose = require('mongoose');
const Pet = require('../model/petModel');

const MONGO_URI = 'mongodb+srv://joaquingabrielcamangeg6:d863ZpS8ywoAhKpI@cluster0.yihls.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0';

// Connect to MongoDB
mongoose.connect(MONGO_URI, {
    useNewUrlParser: true,
    useUnifiedTopology: true,
})
.then(() => console.log('MongoDB connected'))
.catch(err => console.log('Error connecting to MongoDB:', err));

const catsData = [
    {
        name: 'Sir Purrsalot',
        breed: 'Cat',
        gender: 'Male',
        age: 5,
        height: 28,
        weight: 7.5,
        petImageUrl: 'http://localhost:5000/uploads/1730126428276-cat6.jpg',
        description: 'A regal kitty with a penchant for cozy laps and dramatic sighs.',
        specialCareInstructions: 'Prefers his meals served at exactly 7:00 PM.',
        adopteeId: '6712647f532ae485a9f894cf',
        medicalHistory: {
            condition: 'Slightly snooty',
            diagnosisDate: '2024-09-10T16:00:00.000Z',
            treatment: 'Extra head scratches and gourmet treats.',
            veterinarianName: 'Dr. Whiskers',
            clinicName: 'Royal Paw Clinic',
            treatmentDate: '2024-09-10T16:00:00.000Z',
            recoveryStatus: 'Ongoing Treatment',
            notes: 'Loves classical music; dislikes thunderstorms.',
        },
        vaccineHistory: {
            vaccineName: 'Feline Nobility Booster',
            vaccinationDate: '2024-09-15T16:00:00.000Z',
            nextDueDate: '2025-09-15T16:00:00.000Z',
            veterinarianName: 'Dr. Whiskers',
            clinicName: 'Royal Paw Clinic',
            notes: 'Seems indifferent to vaccines; expected to snooze afterward.',
        },
        status: 'available',
    },
    {
        name: 'Meow Zedong',
        breed: 'Cat',
        gender: 'Female',
        age: 3,
        height: 27,
        weight: 5.5,
        petImageUrl: 'http://localhost:5000/uploads/1730126446283-cat7.png',
        description: 'Strategic and loves perching in high places to oversee the room.',
        specialCareInstructions: 'Keep windows closed – she’s an escape artist.',
        adopteeId: '6712647f532ae485a9f894cf',
        medicalHistory: {
            condition: 'Chronic Curiosity',
            diagnosisDate: '2024-07-20T16:00:00.000Z',
            treatment: 'Toys that challenge the mind, daily puzzle sessions.',
            veterinarianName: 'Dr. Katz',
            clinicName: 'Clever Cats Vet',
            treatmentDate: '2024-07-20T16:00:00.000Z',
            recoveryStatus: 'Recovered',
            notes: 'Will try to open cabinets; has figured out door handles.',
        },
        vaccineHistory: {
            vaccineName: 'Sneaky Paw Shot',
            vaccinationDate: '2024-08-01T16:00:00.000Z',
            nextDueDate: '2025-08-01T16:00:00.000Z',
            veterinarianName: 'Dr. Katz',
            clinicName: 'Clever Cats Vet',
            notes: 'Very unimpressed with shots, requires treats to stay calm.',
        },
        status: 'adopted',
    },
    {
        name: 'Chairman Meow',
        breed: 'Cat',
        gender: 'Male',
        age: 4,
        height: 30,
        weight: 6.2,
        petImageUrl: 'http://localhost:5000/uploads/1730126467888-cat8.jpg',
        description: 'Loves to nap on anything important, particularly paperwork.',
        specialCareInstructions: 'Don’t leave important documents lying around.',
        adopteeId: '6712647f532ae485a9f894cf',
        medicalHistory: {
            condition: 'Nap Addiction',
            diagnosisDate: '2024-08-12T16:00:00.000Z',
            treatment: 'Encourage active play, though he’s unlikely to listen.',
            veterinarianName: 'Dr. Pawz',
            clinicName: 'The Cozy Vet Clinic',
            treatmentDate: '2024-08-12T16:00:00.000Z',
            recoveryStatus: 'Recovered',
            notes: 'Favorite nap spots: keyboards, important files, and laps.',
        },
        vaccineHistory: {
            vaccineName: 'Dozy Dose',
            vaccinationDate: '2024-09-01T16:00:00.000Z',
            nextDueDate: '2025-09-01T16:00:00.000Z',
            veterinarianName: 'Dr. Pawz',
            clinicName: 'The Cozy Vet Clinic',
            notes: 'Was asleep for most of the vaccination process.',
        },
        status: 'available',
    },
    {
        name: 'Count Purrcula',
        breed: 'Cat',
        gender: 'Male',
        age: 6,
        height: 31,
        weight: 6.8,
        petImageUrl: 'http://localhost:5000/uploads/1730126493991-cat9.jpg',
        description: 'Only comes out at night, very mysterious and aloof.',
        specialCareInstructions: 'Provide a dark hiding spot to relax.',
        adopteeId: '6712647f532ae485a9f894cf',
        medicalHistory: {
            condition: 'Night Owl Syndrome',
            diagnosisDate: '2024-06-10T16:00:00.000Z',
            treatment: 'None required, just don’t expect him in the daytime.',
            veterinarianName: 'Dr. Fang',
            clinicName: 'Night Paws Veterinary',
            treatmentDate: '2024-06-10T16:00:00.000Z',
            recoveryStatus: 'Chronic',
            notes: 'Does not tolerate sunlight well, prefers dark spaces.',
        },
        vaccineHistory: {
            vaccineName: 'Twilight Tonic',
            vaccinationDate: '2024-07-05T16:00:00.000Z',
            nextDueDate: '2025-07-05T16:00:00.000Z',
            veterinarianName: 'Dr. Fang',
            clinicName: 'Night Paws Veterinary',
            notes: 'Administered at dusk; seems quite pleased.',
        },
        status: 'available',
    },
    {
        name: 'Professor Purrstein',
        breed: 'Cat',
        gender: 'Female',
        age: 3,
        height: 26,
        weight: 5,
        petImageUrl: 'http://localhost:5000/uploads/1730126506690-cat10.jpg',
        description: 'Very wise and contemplative; prefers to observe rather than participate.',
        specialCareInstructions: 'Provide bookshelves or high surfaces to observe from.',
        adopteeId: '6712647f532ae485a9f894cf',
        medicalHistory: {
            condition: 'Philosophical Tendency',
            diagnosisDate: '2024-09-25T16:00:00.000Z',
            treatment: 'None, but provide intellectual stimulation.',
            veterinarianName: 'Dr. Sphinx',
            clinicName: 'Thinker’s Veterinary',
            treatmentDate: '2024-09-25T16:00:00.000Z',
            recoveryStatus: 'Ongoing Treatment',
            notes: 'Seems to be contemplating life’s great mysteries.',
        },
        vaccineHistory: {
            vaccineName: 'Curious Cat Jab',
            vaccinationDate: '2024-10-01T16:00:00.000Z',
            nextDueDate: '2025-10-01T16:00:00.000Z',
            veterinarianName: 'Dr. Sphinx',
            clinicName: 'Thinker’s Veterinary',
            notes: 'Took the vaccine calmly, as if pondering its purpose.',
        },
        status: 'available',
    }
];

// Function to seed the database with new, quirky cat data
const seedCats = async () => {
    try {
        await Pet.insertMany(catsData);
        console.log('5 unique cats have been successfully added to the database.');
    } catch (err) {
        console.error('Error seeding cats:', err);
    } finally {
        mongoose.connection.close();
    }
};

// Run the seeder
seedCats();
