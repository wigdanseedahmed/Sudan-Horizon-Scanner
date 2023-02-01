// Import Schemas

// Import Mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create Coalition Detail Schema and Model
const PoliticalMappingReferencesDetailSchema= new Schema({
    link: {
        type: String
    },
    createdBy: {
        type: String
    }
  });


module.exports = PoliticalMappingReferencesDetailSchema;