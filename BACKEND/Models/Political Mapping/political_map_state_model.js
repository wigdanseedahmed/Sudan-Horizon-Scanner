// Import Schemas

// Import Mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create State Detail Schema and Model
const PoliticalMappingStateDetailSchema= new Schema({
    overview: {
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
    summary: {
        type: String
    },
  });


// Create State Schema and Model
const PoliticalMappingStateSchema = new Schema({

    eventId: {
        type: String,
        unique: [true]
    },
    eventNameEn: {
        type: String,
        required: [true]
    },
    eventNameAr: {
        type: String
    },
    photoUrl: {
        type: String
    },
    eventDetailEn: PoliticalMappingStateDetailSchema,
    eventDetailAr: PoliticalMappingStateDetailSchema,
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
peopleAffectedPositivelyEn: {
    type: [String]
},
peopleAffectedPositivelyAr: {
    type: [String]
},
partyGroupAffectedPositivelyEn: {
    type: [String]
},
partyGroupAffectedPositivelyAr: {
    type: [String]
},
peopleAffectedNegativelyEn: {
    type: [String]
},
peopleAffectedNegativelyAr: {
    type: [String]
},
partyGroupAffectedNegativelyEn: {
    type: [String]
},
partyGroupAffectedNegativelyAr: {
    type: [String]
},
dataReliability: {
        type: String
    }

});

const PoliticalMappingStateModel = mongoose.model('political_mapping_state_data', PoliticalMappingStateSchema, 'political_mapping_state_data');
module.exports = {
    PoliticalMappingStateModel: PoliticalMappingStateModel,
    PoliticalMappingStateSchema: PoliticalMappingStateSchema
};