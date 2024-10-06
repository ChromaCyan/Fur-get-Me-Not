const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
    firstName: {type: String, required: true},
    lastName: {type: String, required: true},
    email: {type: String, required: true},
    password: {type: String, required: true},
    //role: {type: String, required: true},
    role: {type: String, enum: ['adopter', 'adoptee']},
    
});

model.exports = mongoose.model("User", userSchema);