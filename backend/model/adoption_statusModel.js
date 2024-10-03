const mongoose = require("mongoose");

const adoption_statusSchema = new mongoose.Schema({
   petName: {type: String, required: true}, 
   ownerName: {type: String, required: true}, 
   status: {type: String, required: true},
   requestDate: {type: String, required: true}, 

});

const AdoptionStatus = mongoose.model("AdoptionStatus", adoption_statusSchema);
module.exports = AdoptionStatus;