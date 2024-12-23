const User = require('../model/userModel');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const nodemailer = require('nodemailer');
const crypto = require('crypto'); 
const dotenv = require("dotenv");

// JWT Secret key
const JWT_SECRET = process.env.JWT_SECRET || 'your_jwt_secret_key'; 

// Temporary storage for OTPs
const otps = {};

// Helper function to generate OTP
const generateOTP = () => {
    return crypto.randomInt(100000, 999999).toString();
};

// Function to send email (I was fucking stuck here for 2 hours cause i forgot to add gmail on the service lmao)
const sendEmail = async (email, otp) => {
    try {
        const transporter = nodemailer.createTransport({
            service: 'gmail',
            auth: {
                user: process.env.EMAIL, 
                pass: process.env.EMAIL_PASSWORD 
            }
        });

        const mailOptions = {
            from: process.env.EMAIL, 
            to: email, 
            subject: 'Your OTP Code',
            text: `Your OTP code is ${otp}. It expires in 5 minutes.`
        };

        await transporter.sendMail(mailOptions);
        console.log('Email sent successfully');
    } catch (error) {
        console.error('Error sending email:', error);
        throw new Error('Error sending email');
    }
};


// OTP Verification Part here
exports.verifyOTP = async (req, res) => {
    const { email, otp } = req.body; 
    const storedOTP = otps[email];
    console.log('Verifying OTP for:', email);
    console.log('Current stored OTPs:', otps);


    if (!storedOTP) {
        return res.status(404).json({ success: false, message: 'No OTP found for this email' });
    }
    
    if (storedOTP.expires < Date.now()) {
        delete otps[email]; 
        return res.status(400).json({ success: false, message: 'OTP has expired' });
    }
    
    if (storedOTP.otp !== otp) {
        return res.status(400).json({ success: false, message: 'Invalid OTP' });
    }

    delete otps[email]; 
    return res.status(200).json({ success: true, message: 'OTP verified' });
};


// CREATE USER with OTP verification
exports.createUser = async (req, res) => {
    const { firstName, lastName, email, password, address, role, profileImage } = req.body;

    try {
        const existingUser = await User.findOne({ email });
        if (existingUser) {
            return res.status(400).json({ message: "User already exists" });
        }

        const newUser = new User({
            firstName,
            lastName,
            email,
            password,
            role,
            profileImage,
            address,
        });

        await newUser.save();

        const otp = generateOTP();
        otps[email] = { otp, expires: Date.now() + 300000 };
        await sendEmail(email, otp);
        console.log('Stored OTPs:', otps); 

        const token = jwt.sign({ id: newUser._id, role: newUser.role }, JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN || '3h' });

        res.status(201).json({ message: "User created successfully, OTP sent", userId: newUser._id, token });
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
};


// GET ALL USERS (For postman testing to know if creating users work)
exports.getUser = async (req, res) => {
    try {
        const users = await User.find();
        res.status(200).json(users);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// GET USER BY ID (For profile display later)
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

// Upload a profile image for a user (Fucking hate this part, got stuck for 8 hours trying to make the filePath work)
exports.uploadProfileImage = async (req, res) => {
  try {
    if (!req.file) {
      return res.status(400).json({ message: 'No file uploaded' });
    }

    const filePath = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;

    res.status(200).json({ imageUrl: filePath });
  } catch (error) {
    console.error(error);
    res.status(500).json({ message: 'Error uploading image', error });
  }
};

// LOGIN USER
exports.loginUser = async (req, res) => {
    const { email, password } = req.body;

    try {
        const user = await User.findOne({ email });
        if (!user) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        const isMatch = await bcrypt.compare(password, user.password);
        if (!isMatch) {
            return res.status(400).json({ message: 'Invalid credentials' });
        }

        const token = jwt.sign({ id: user._id, role: user.role }, JWT_SECRET, { expiresIn: process.env.JWT_EXPIRES_IN || '3h' });
        res.status(200).json({ token, userId: user._id, role: user.role });

    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};

// UPDATE USER
exports.updateUser = async (req, res) => {
  const { id } = req.params;
  const { firstName, lastName, address } = req.body;

  try {
    console.log('Request Body:', req.body);
    console.log('Uploaded File:', req.file);

    const existingUser = await User.findById(id);
    if (!existingUser) {
      return res.status(404).json({ message: "User not found" });
    }

    const updatedData = {
      ...existingUser.toObject(),  
      ...req.body,               
    };

    if (req.file) {
      const filePath = `${req.protocol}://${req.get('host')}/uploads/${req.file.filename}`;
      
      updatedData.profileImage = filePath;
      
      console.log('New Profile Image URL:', filePath);
    }

    console.log('Update Fields:', updatedData);

    const updatedUser = await User.findByIdAndUpdate(id, updatedData, { new: true });

    console.log('Updated User:', updatedUser);

    if (!updatedUser) {
      return res.status(404).json({ message: "User not found" });
    }

    res.status(200).json(updatedUser);
  } catch (error) {
    console.error('Error updating user:', error);
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
        res.status(204).end(); 
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};
