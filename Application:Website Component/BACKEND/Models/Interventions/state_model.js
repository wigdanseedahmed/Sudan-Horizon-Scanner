var mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create State Schema and Model
const StateSchema = new Schema({

    StateId: {
        type: Number,
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
    Province_PCODE:{
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
    Government_Type: {
        type: String
    },
    Government_Chief_Administrator:{
        type: String
    },
    Government_Governor: {
        type: String
    },
    Population: {
        type: Number,
    },
    Type: {
        type: String,
        default: "Polygon"
    },
    Shape_Area: {
        type: Number,
    },
Latitude: {
        type: Number,
    },
    Longitude:{
        type: Number,
    },
    coordinates: { type: [Number], index: '2dsphere'},
    Most_Intervention_Type: {
        type: String
    },
    Least_Intervention_Type: {
            type: String
        },
        No_Intervention_Type: {
            type: String
        }
})

const statesModel= mongoose.model('interventions_state_map', StateSchema, 'interventions_state_map');
module.exports = {
    statesModel: statesModel, 
    StateSchema: StateSchema
};