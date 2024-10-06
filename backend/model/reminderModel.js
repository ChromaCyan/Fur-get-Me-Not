const mongoose = require("mongoose");

const reminderSchema = new mongoose.Schema({
    id: { type: String, required: true},
    title: {type: String, required: true},
    description: {type: String, required: true},
    reminderDate: {type: String, required: true},
    repeat: {type: Boolean, required: true},
}); 

const Reminder = mongoose.model("reminderSchema", reminderSchema);

module.exports = Reminder;