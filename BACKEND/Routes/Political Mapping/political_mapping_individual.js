const  { 
    getPoliticalMappingIndividualActors,
    getPoliticalMappingIndividualActorByID,
    getPoliticalMappingIndividualActorByIndividualActorName,
     createPoliticalMappingIndividualActor,
     updatePoliticalMappingIndividualActorByID,
     updatePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName,
     deletePoliticalMappingIndividualActorByID,
     deletePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName

} = require('../../Controller/Political Mapping/political_map_individual_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/politicalindividualactor', getPoliticalMappingIndividualActors);

router.get('/politicalindividualactor/findbyindividualactorid/:id', getPoliticalMappingIndividualActorByID);

router.get('/politicalindividualactor/findbyindividualactorname/:politicalMappingIndividualActorName', getPoliticalMappingIndividualActorByIndividualActorName);

// Add new politicalindividualactor to the DB
router.post('/politicalindividualactor', createPoliticalMappingIndividualActor);

// Update a politicalindividualactor in the DB
router.put('/politicalindividualactor/politicalindividualactorid/:id', updatePoliticalMappingIndividualActorByID);

router.put('/politicalindividualactor/politicalindividualactornameen/:politicalMappingIndividualActorName', updatePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName);

// Delete a politicalindividualactor from the DB
router.delete('/politicalindividualactor/politicalindividualactorid/:id', deletePoliticalMappingIndividualActorByID);

router.delete('/politicalindividualactor/politicalindividualactornameen/:politicalMappingIndividualActorName', deletePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName);


module.exports = router;