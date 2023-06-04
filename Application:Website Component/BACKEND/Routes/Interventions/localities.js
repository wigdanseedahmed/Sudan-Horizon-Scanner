const  { 
    getLocalities,
    createLocality,
    updateLocalityByID,
    updateLocalityByLocalityName,
    deleteLocalityByID,
    deleteLocalityByLocalityName,
    countMostInterventionTypePerLocality
} = require('../../Controller/Interventions/localities_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/locality', getLocalities);

// Add new locality to the DB
router.post('/locality', createLocality);

// Update a locality in the DB
router.put('/locality/localityid/:id', updateLocalityByID);

router.put('/locality/localitynameen/:localityNameEN', updateLocalityByLocalityName);

// Delete a locality from the DB
router.delete('/locality/localityid/:id', deleteLocalityByID);

router.delete('/locality/localitynameen/:localityNameEN', deleteLocalityByLocalityName);

// Count projects based on themes and Locality
router.get('/locality/count/theme', countMostInterventionTypePerLocality);

module.exports = router;