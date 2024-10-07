// authMiddleware.js
const jwt = require('jsonwebtoken');
const User = require('../model/userModel'); // Import user model

// Middleware to verify JWT and check roles
const verifyTokenAndRole = (roles = []) => {
    return async (req, res, next) => {
        const token = req.headers['authorization'];
        if (!token) return res.status(401).json({ message: 'No token provided' });

        try {
            const decoded = jwt.verify(token, process.env.JWT_SECRET || 'your_jwt_secret_key');
            req.user = decoded;

            // Fetch the user from the database
            const user = await User.findById(decoded.id);
            if (!user) return res.status(404).json({ message: 'User not found' });

            // Check if the user's role matches the allowed roles
            if (roles.length && !roles.includes(user.role)) {
                return res.status(403).json({ message: 'Access denied' });
            }

            next(); // Proceed to the next middleware or route handler
        } catch (error) {
            return res.status(401).json({ message: 'Invalid token' });
        }
    };
};

module.exports = verifyTokenAndRole;
