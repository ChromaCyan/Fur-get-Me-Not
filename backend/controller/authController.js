const User = require('../model/userModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

// JWT Secret key
const JWT_SECRET = process.env.JWT_SECRET || 'your_jwt_secret_key'; 

// GET ALL USERS
exports.getUser = async (req, res) => {
    try {
        const users = await User.find();
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// GET USER BY ID
exports.getUserById = async (req, res) => {
    const { id } = req.params;

    try {
        const user = await User.findById(id);
        if (!user) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json(user);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// CREATE USER
exports.createUser = async (req, res) => {
    const { firstName, lastName, email, password, role } = req.body;

    try {
        // Check if the user already exists
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: "User already exists" });
        }

        const newUser = new User({
            firstName,
            lastName,
            email,
            password, // No need to hash here
            role,
        });

        await newUser.save();

        // Generate JWT for the newly created user
        const token = jwt.sign({ id: newUser._id, role: newUser.role }, JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN || '3h' });

        res.status(201).json({ message: "User created successfully", userId: newUser._id, token });
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};


// LOGIN USER
exports.loginUser = async (req, res) => {
    const { email, password } = req.body;

    console.log("Incoming email:", email);
    console.log("Incoming password:", password);

    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        // Log the stored hashed password
        console.log("Stored hashed password:", user.password); 

        // Compare the provided password with the hashed password
        const isMatch = await bcrypt.compare(password, user.password);
        console.log("Password match result:", isMatch); // Log the result

        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        // Generate JWT
        const token = jwt.sign({ id: user._id, role: user.role }, JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN || '3h' });
        res.status(200).json({ token, userId: user._id, role: user.role });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// UPDATE USER
exports.updateUser = async (req, res) => {
    const { id } = req.params;
    const { firstName, lastName, email, password, role } = req.body;

    try {
        // Only update the password if it is provided and modified
        if (password) {
            req.body.password = password; // Keep password as-is, Mongoose middleware will handle hashing
        }

        const updatedUser = await User.findByIdAndUpdate(id, req.body, { new: true });
        if (!updatedUser) {
            return res.status(404).json({ message: "User not found" });
        }
        res.status(200).json(updatedUser);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};


// DELETE USER
exports.deleteUser = async (req, res) => {
    const { id } = req.params;

    try {
        const user = await User.findByIdAndDelete(id);
        if (!user) {
            return res.status(404).json({ message: "User not found!" });
        }
        res.status(204).end(); // No content response
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
