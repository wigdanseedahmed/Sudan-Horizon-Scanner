// Import Schemas
PoliticalMappingReferencesDetailSchema = require('../../Models/Political Mapping/political_map_references_model');

// Import Mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create Individual Detail Schema and Model
const PoliticalMappingIndividualActorDetailSchema= new Schema({
    overview: {
        type: String
    },
    personalBackground: {
        type: String
    },
    educationBackground: {
        type: String
    },
    earlyAndInternationalCareer: {
        type: String
    },
    politicalCareer: {
        type: String
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
  

// Create Individual Schema and Model
const PoliticalMappingIndividualActorSchema = new Schema({

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
    actorTypeEn: {
        type: String,
        required: [true]
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
    actorAffiliationGroupPartyNameEn: {
        type: String
    },
    actorAffiliationGroupPartyNameAr: {
        type: String
    },
    photoUrl: {
        type: String
    },
    status: {
        type: String
    },
    jobTitle: {
        type: String
    },
    status: {
        type: String
    },
    actorDetailEn: PoliticalMappingIndividualActorDetailSchema,
    actorDetailAr: PoliticalMappingIndividualActorDetailSchema,
    startDate: {
        type: Date
    },
    endDate: {
        type: Date
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

const PoliticalMappingIndividualActorModel = mongoose.model('political_mapping_individual_data', PoliticalMappingIndividualActorSchema, 'political_mapping_individual_data');
module.exports = {
    PoliticalMappingIndividualActorModel: PoliticalMappingIndividualActorModel,
    PoliticalMappingIndividualActorSchema: PoliticalMappingIndividualActorSchema
};