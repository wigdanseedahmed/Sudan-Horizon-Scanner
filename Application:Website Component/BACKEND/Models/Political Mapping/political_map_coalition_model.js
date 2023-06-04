// Import Schemas
PoliticalMappingReferencesDetailSchema = require('../../Models/Political Mapping/political_map_references_model');

// Import Mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create Coalition Detail Schema and Model
const PoliticalMappingCoalitionDetailSchema= new Schema({
    overview: {
        type: String
    },
    historicalBackground: {
        type: String
    },
    details: {
        type: String
    },
    effectedOnPeople: {
        type: String
    },
    effectOnPartiesGroups: {
        type: String
    },
    outcome: {
        type: String
    },
    summary: {
        type: String
    },
    references: [PoliticalMappingReferencesDetailSchema]
  });


// Create Coalition Schema and Model
const PoliticalMappingCoalitionSchema = new Schema({

    coalitionsId: {
        type: String,
        unique: [true]
    },
    coalitionsNameEn: {
        type: String,
        required: [true]
    },
    coalitionsNameAr: {
        type: String
    },
    photoUrl: {
        type: String
    },
    referencesEn: {
        type: String
    },
    referencesAr: {
        type: String
    },
    coalitionTypeEn: {
        type: String
    },
    coalitionTypeAr: {
        type: String
    },
    coalitionMediatorEn: {
        type: String
    },
    coalitionMediatorAr: {
        type: String
    },
    coalitionsDetailEn: PoliticalMappingCoalitionDetailSchema,
    coalitionsDetailAr: PoliticalMappingCoalitionDetailSchema,
    startDate: {
        type: Date
    },
    endDate: {
        type: Date
    },
    localityNameEn: {
        type: String,
    },
    localityNameAr: {
        type: String
    },
    localityNamePcode: {
        type: String
    },
    stateNameEn: {
        type: String
    },
    stateNameAr: {
        type: String
    },
    stateNamePcode: {
        type: String
    },
    countryEn: {
        type: String
    },
    countryAr: {
        type: String
    },
    countryPcode: {
        type: String
    },
    peopleInvolvedEn: {
        type: [String]
    },
   peopleInvolvedAr: {
    type: [String]
},
partyGroupInvolvedEn: {
    type: [String]
},
partyGroupInvolvedAr: {
    type: [String]
},
consequenceSignEn: {
    type: [String]
},
consequenceSignAr: {
    type: [String]
},
dataReliability: {
        type: String
    }

});

const PoliticalMappingCoalitionModel = mongoose.model('political_mapping_coalition_data', PoliticalMappingCoalitionSchema, 'political_mapping_coalition_data');
module.exports = {
    PoliticalMappingCoalitionModel: PoliticalMappingCoalitionModel,
    PoliticalMappingCoalitionSchema: PoliticalMappingCoalitionSchema
};