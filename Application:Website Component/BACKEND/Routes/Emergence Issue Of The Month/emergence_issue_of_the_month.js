const  { 
    getEmergingIssues,
    getEmergingIssueByName,
  createEmergingIssue,
  updateEmergingIssueByID,
  updateEmergingIssueByEmergingIssueName,
  deleteEmergingIssueByID,
  deleteEmergingIssueByEmergingIssueName

} = require('../../Controller/Emergence Issue Of The Month/emergence_issue_of_the_month_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/emergenceIssueOfTheMonth', getEmergingIssues);

router.get('/emergenceIssueOfTheMonth/findbyname/:emergingIssue', getEmergingIssueByName);

// Add new emergenceIssueOfTheMonth to the DB
router.post('/emergenceIssueOfTheMonth', createEmergingIssue);

// Update a emergenceIssueOfTheMonth in the DB
router.put('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthid/:id', updateEmergingIssueByID);

router.put('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameen/:emergingIssue', updateEmergingIssueByEmergingIssueName);

// Delete a emergenceIssueOfTheMonth from the DB
router.delete('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthid/:id', deleteEmergingIssueByID);

router.delete('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameen/:politicalMappingEventName', deleteEmergingIssueByEmergingIssueName);


module.exports = router;