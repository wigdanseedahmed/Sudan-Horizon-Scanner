// Import Schemas
const DonorSchema = require('./donor_model');
const ExecutingAgencySchema = require('./executing_agency_model');
const {
    LocalitySchema
} = require('./locality_model');
const {
    StateSchema
} = require('./state_model');

// Import Mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema;


// Create Project Schema and Model
const ProjectSchema = new Schema({

    id: {
        type: String,
        required: [true]
    },
    projectNo: {
        type: Number
    },
    projectName: {
        type: String,
        required: [true]
    },
    projectDetail: {
        type: String
    },
    photoURL: {
        type: String
    },
    executingAgency: [ExecutingAgencySchema],
    status: {
        type: String
    },
    theme: {
        type: [String]
    },
    estimatedCost: {
        type: Number
    },
    budget: {
        type: Number
    },
    totalDonatedAmount: {
        type: Number
    },
    startDate: {
        type: Date
    },
    endDate: {
        type: Date
    },
    Latitude: {
        type: Number
    },
    Longitude: {
        type: Number
    },
    Locality_Name_EN: {
        type: String,
    },
    Locality_Name_AR: {
        type: String
    },
    Locality_Name_PCODE: {
        type: String
    },
    City_Name_EN: {
        type: String
    },
    City_Name_AR: {
        type: String
    },
    City_PCODE: {
        type: String
    },
    State_Name_EN: {
        type: String
    },
    State_Name_AR: {
        type: String
    },
    State_Name_PCODE: {
        type: String
    },
    Province_Name_EN: {
        type: String
    },
    Province_Name_AR: {
        type: String
    },
    Province_PCODE: {
        type: String
    },
    Region_Name_EN: {
        type: String
    },
    Region_Name_AR: {
        type: String
    },
    Region_PCODE: {
        type: String
    },
    Country_EN: {
        type: String
    },
    Country_AR: {
        type: String
    },
    Country_PCODE: {
        type: String
    },
    donor: [DonorSchema],
    contribution: {
        type: String
    },
    dataReliability: {
        type: String
    }

});

const projectsModel = mongoose.model('project_data', ProjectSchema, 'project_data');
module.exports = {
    projectsModel: projectsModel,
    ProjectSchema: ProjectSchema
};