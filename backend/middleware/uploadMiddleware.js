const multer = require('multer');
const path = require('path');

// Configure multer storage
const storage = multer.diskStorage({
  destination: (req, file, cb) => {
    cb(null, 'uploads/');
  },
  filename: (req, file, cb) => {
    cb(null, `${Date.now()}-${file.originalname}`);
  },
});

// Create multer instance
const upload = multer({ storage });

// Middleware to handle image uploads
const uploadPetImage = upload.single('petImage');

module.exports = { uploadPetImage };
