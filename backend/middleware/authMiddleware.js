// middleware/authMiddleware.js

const jwt = require('jsonwebtoken');
const dotenv = require('dotenv');

// Load environment variables (make sure to have a .env file with your secret key)
dotenv.config();

const secretKey = process.env.JWT_SECRET || 'yourSecretKeyHere';

// Middleware to verify JWT Token
function verifyToken(req, res, next) {
  const token = req.header('Authorization')?.split(' ')[1]; 

  if (!token) {
    return res.status(401).json({ message: 'Access Denied! No Token Provided.' });
  }

  try {
    // Verify the token
    const decoded = jwt.verify(token, secretKey);
    req.user = decoded; // Attach the decoded user information to the request
    next(); // Proceed to the next middleware or route handler
  } catch (error) {
    console.error('Token verification error:', error.message); // Log the error for debugging
    res.status(400).json({ message: 'Invalid Token.' });
  }
}


// Middleware to check if the user is an Adopter
function isAdopter(req, res, next) {
  if (req.user && req.user.role === 'adopter') {
    next();
  } else {
    res.status(403).json({ message: 'Forbidden! You are not an Adopter.' });
  }
}

// Middleware to check if the user is an Adoptee
function isAdoptee(req, res, next) {
  if (req.user && req.user.role === 'adoptee') {
    next();
  } else {
    res.status(403).json({ message: 'Forbidden! You are not an Adoptee.' });
  }
}

// Export the middleware functions
module.exports = {
  verifyToken,
  isAdopter,
  isAdoptee,
};
