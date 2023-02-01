// Import Schemas
PoliticalMappingReferencesDetailSchema = require('../../Models/Political Mapping/political_map_references_model');

// Import Mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create Event Detail Schema and Model
const PoliticalMappingEventDetailSchema= new Schema({
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
    references: [PoliticalMappingReferencesDetailSchema]
  });


// Create Event Schema and Model
const PoliticalMappingEventSchema = new Schema({

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
    eventDetailEn: PoliticalMappingEventDetailSchema,
    eventDetailAr: PoliticalMappingEventDetailSchema,
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

const PoliticalMappingEventModel = mongoose.model('political_mapping_event_data', PoliticalMappingEventSchema, 'political_mapping_event_data');
module.exports = {
    PoliticalMappingEventModel: PoliticalMappingEventModel,
    PoliticalMappingEventSchema: PoliticalMappingEventSchema
};