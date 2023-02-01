const  { 
    getPoliticalMappingStates,
    getPoliticalMappingStateByID,
    getPoliticalMappingStateByStateName,
     createPoliticalMappingState,
     updatePoliticalMappingStateByID,
     updatePoliticalMappingStateByPoliticalMappingStateName,
     deletePoliticalMappingStateByID,
     deletePoliticalMappingStateByPoliticalMappingStateName

} = require('../../Controller/Political Mapping/political_map_state_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/politicalstate', getPoliticalMappingStates);

router.get('/politicalstate/findbystateid/:id', getPoliticalMappingStateByID);

router.get('/politicalstate/findbystatename/:politicalMappingStateName', getPoliticalMappingStateByStateName);

// Add new politicalstate to the DB
router.post('/politicalstate', createPoliticalMappingState);

// Update a politicalstate in the DB
router.put('/politicalstate/politicalstateid/:id', updatePoliticalMappingStateByID);

router.put('/politicalstate/politicalstatenameen/:politicalMappingStateName', updatePoliticalMappingStateByPoliticalMappingStateName);

// Delete a politicalstate from the DB
router.delete('/politicalstate/politicalstateid/:id', deletePoliticalMappingStateByID);

router.delete('/politicalstate/politicalstatenameen/:politicalMappingStateName', deletePoliticalMappingStateByPoliticalMappingStateName);


module.exports = router;