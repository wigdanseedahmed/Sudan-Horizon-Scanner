const  { 
    getPoliticalMappingEvents,
    getPoliticalMappingEventByID,
    getPoliticalMappingEventByEventName,
     createPoliticalMappingEvent,
     updatePoliticalMappingEventByID,
     updatePoliticalMappingEventByPoliticalMappingEventName,
     deletePoliticalMappingEventByID,
     deletePoliticalMappingEventByPoliticalMappingEventName

} = require('../../Controller/Political Mapping/political_map_event_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/politicalevent', getPoliticalMappingEvents);

router.get('/politicalevent/findbyeventid/:id', getPoliticalMappingEventByID);

router.get('/politicalevent/findbyeventname/:politicalMappingEventName', getPoliticalMappingEventByEventName);

// Add new politicalevent to the DB
router.post('/politicalevent', createPoliticalMappingEvent);

// Update a politicalevent in the DB
router.put('/politicalevent/politicaleventid/:id', updatePoliticalMappingEventByID);

router.put('/politicalevent/politicaleventnameen/:politicalMappingEventName', updatePoliticalMappingEventByPoliticalMappingEventName);

// Delete a politicalevent from the DB
router.delete('/politicalevent/politicaleventid/:id', deletePoliticalMappingEventByID);

router.delete('/politicalevent/politicaleventnameen/:politicalMappingEventName', deletePoliticalMappingEventByPoliticalMappingEventName);


module.exports = router;