const  { 
    getStates,
    createState,
    updateStateByID,
    updateStateByStateNameEN,
    deleteStateByID,
    deleteStateByStateNameEN,
    countMostInterventionTypePerState
} = require('../../Controller/Interventions/states_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/state', getStates);

// Add new state to the DB
router.post('/state', createState);

// Update a state in the DB
router.put('/state/stateid/:id', updateStateByID);

router.put('/state/statenameen/:stateNameEN', updateStateByStateNameEN);

// Delete a state from the DB
router.delete('/state/stateid/:id', deleteStateByID);

router.put('/state/statenameen/:stateNameEN', deleteStateByStateNameEN);

// Count projects based on themes and Locality
router.get('/state/count/theme', countMostInterventionTypePerState);

module.exports = router;