const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create donor Schema
const DonorSigma = new Schema({
    donorName: {
        type: String,
        required: [true]
    },
    donorEmail: {
        type: String,
        unique: true
    },
    donorWebsite: {
        type: String,
        unique: true
    },
    donorPhotoUrl: {
        type: String
    },
    donorProjectList:{
        type:[String]
    },
    donationAmount: {
        type: Number
    }
})

module.exports = DonorSigma;