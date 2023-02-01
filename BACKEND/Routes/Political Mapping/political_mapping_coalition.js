const  { 
    getPoliticalMappingCoalitions,
    getPoliticalMappingCoalitionByID,
    getPoliticalMappingCoalitionByCoalitionName,
     createPoliticalMappingCoalition,
     updatePoliticalMappingCoalitionByID,
     updatePoliticalMappingCoalitionByPoliticalMappingCoalitionName,
     deletePoliticalMappingCoalitionByID,
     deletePoliticalMappingCoalitionByPoliticalMappingCoalitionName

} = require('../../Controller/Political Mapping/political_map_coalition_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/politicalcoalition', getPoliticalMappingCoalitions);

router.get('/politicalcoalition/findbycoalitionid/:id', getPoliticalMappingCoalitionByID);

router.get('/politicalcoalition/findbycoalitionname/:politicalMappingCoalitionName', getPoliticalMappingCoalitionByCoalitionName);

// Add new politicalcoalition to the DB
router.post('/politicalcoalition', createPoliticalMappingCoalition);

// Update a politicalcoalition in the DB
router.put('/politicalcoalition/politicalcoalitionid/:id', updatePoliticalMappingCoalitionByID);

router.put('/politicalcoalition/politicalcoalitionnameen/:politicalMappingCoalitionName', updatePoliticalMappingCoalitionByPoliticalMappingCoalitionName);

// Delete a politicalcoalition from the DB
router.delete('/politicalcoalition/politicalcoalitionid/:id', deletePoliticalMappingCoalitionByID);

router.delete('/politicalcoalition/politicalcoalitionnameen/:politicalMappingCoalitionName', deletePoliticalMappingCoalitionByPoliticalMappingCoalitionName);


module.exports = router;