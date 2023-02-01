// Import Schemas
PoliticalMappingReferencesDetailSchema = require('../../Models/Political Mapping/political_map_references_model');

// Import Mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create PartyGroup Detail Schema and Model
const PoliticalMappingPartyGroupActorDetailSchema= new Schema({
    overview: {
        type: String
    },
    actorBackground: {
        type: String
    },
    politicalCareer: {
        type: String
    },
    ideologies: {
        type: [String]
    },
    views: {
        type: String
    },
    predictions: {
        type: String
    },
    summary: {
        type: String
    },
    references: [PoliticalMappingReferencesDetailSchema]
  });

// Create PartyGroup Schema and Model
const PoliticalMappingPartyGroupActorSchema = new Schema({

    actorId: {
        type: String,
        unique: [true]
    },
    actorNameEn: {
        type: String,
        required: [true]
    },
    actorNameAr: {
        type: String
    },
    
    photoUrl: {
        type: String
    },
    actorTypeEn: {
        type: String
    },
    actorTypeAr: {
        type: String
    },
    actorAffiliationGroupPartyTypeEn: {
        type: String
    },
    actorAffiliationGroupPartyTypeAr: {
        type: String
    },
    actorMemberNamesEn: {
        type: [String]
    },
    actorMemberNamesAr: {
        type: [String]
    },
    status: {
        type: String
    },
    actorDetailEn: PoliticalMappingPartyGroupActorDetailSchema,
    actorDetailAr: PoliticalMappingPartyGroupActorDetailSchema,
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
    
    status: {
    type: String
},
actorLeaderEn: {
    type: String
},
actorLeaderAr: {
    type: String
},

coalitionNameEn: {
    type: [String]
},
coalitionNameAr: {
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

const PoliticalMappingPartyGroupActorModel = mongoose.model('political_mapping_party_group_data', PoliticalMappingPartyGroupActorSchema, 'political_mapping_party_group_data');
module.exports = {
    PoliticalMappingPartyGroupActorModel: PoliticalMappingPartyGroupActorModel,
    PoliticalMappingPartyGroupActorSchema: PoliticalMappingPartyGroupActorSchema
};