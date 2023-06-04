const  { 
    getPoliticalMappingPartyGroupActors,
    getPoliticalMappingPartyGroupActorByID,
    getPoliticalMappingPartyGroupActorByPartyGroupActorName,
     createPoliticalMappingPartyGroupActor,
     updatePoliticalMappingPartyGroupActorByID,
     updatePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName,
     deletePoliticalMappingPartyGroupActorByID,
     deletePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName

} = require('../../Controller/Political Mapping/political_map_party_group_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/politicalpartygroupactor', getPoliticalMappingPartyGroupActors);

router.get('/politicalpartygroupactor/findbypartygroupactorid/:id', getPoliticalMappingPartyGroupActorByID);

router.get('/politicalpartygroupactor/findbypartygroupactorname/:politicalMappingPartyGroupActorName', getPoliticalMappingPartyGroupActorByPartyGroupActorName);

// Add new politicalpartygroupactor to the DB
router.post('/politicalpartygroupactor', createPoliticalMappingPartyGroupActor);

// Update a politicalpartygroupactor in the DB
router.put('/politicalpartygroupactor/politicalpartygroupactorid/:id', updatePoliticalMappingPartyGroupActorByID);

router.put('/politicalpartygroupactor/politicalpartygroupactornameen/:politicalMappingPartyGroupActorName', updatePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName);

// Delete a politicalpartygroupactor from the DB
router.delete('/politicalpartygroupactor/politicalpartygroupactorid/:id', deletePoliticalMappingPartyGroupActorByID);

router.delete('/politicalpartygroupactor/politicalpartygroupactornameen/:politicalMappingPartyGroupActorName', deletePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName);


module.exports = router;