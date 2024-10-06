const mongoose = require("mongoose");

const AdoptionRequestSchema = new mongoose.Schema({
	adopterID: {type: String, required: true},
	status: {type: String, required: true},
	pet: {type: String, required: true},
	form: {type: String, required: true},
}, { timestamps: true }
);

module.exports = mongoose.model("AdoptionRequest", AdoptionRequestSchema);