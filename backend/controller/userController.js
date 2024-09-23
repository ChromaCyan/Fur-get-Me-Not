const User = require('../model/userModel');

//GETS
exports.getUser = async (req, res) => {
    try {
        const user = await User.find();
        res.status(200).json(user)
    } catch (error) {
        res.status(500).json({message: error.message});
    }
}

//GET USER BY ID
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

//CREATE
exports.createUser = async (req, res) => {
    console.log(req.body);
    const{firstName, lastName, email, password, role} = req.body;

    console.log("========== Student Profile ==========");
    console.log("First Name:", firstName);
    console.log("Last Name:", lastName);
    console.log("Email:", email);
    console.log("Password:", password);
    console.log("Role:", role);

try {
    const newUser = new User({
        firstName,
        lastName,
        email,
        password,
        role,
    });
    await newUser.save();
    res.status(201).json(newUser);
} catch (error) {
    res.status(400).json({ message: error.message });
}

}

//UPDATE
exports.updateUser = async (req, res) => {
    const {id} = req.params;
    const{firstName, lastName, email, password, role} = req.body;

    try {
        const updatedUser = await User.findByIdAndUpdate(
            id,
            {firstName, lastName, email, password, role},
            {new: true}
        );
        res.status(200).json(updatedUser);
    } catch (error) {
        res.status(400).json({ message: error.message });
    }
}

//DELETE
exports.deleteUser = async (req, res) => {
    const {id} = req.params;
    
    try {
        const user = await User.findByIdAndUpdate(id);
        if (!profile){
            return res.status(404).json({ message: "Profile not found" });
        }
        res.status(204).end(); // No content response
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};