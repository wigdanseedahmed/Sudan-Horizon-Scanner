const  { 
    getEmergingIssuesData,
    getEmergingIssueDataByName,
  createEmergingIssueData,
  updateEmergingIssueDataByID,
  updateEmergingIssueDataByEmergingIssueName,
  deleteEmergingIssueDataByID,
  deleteEmergingIssueDataByEmergingIssueName

} = require('../../Controller/Emergence Issue Of The Month/emergence_issue_of_the_month_data_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/emergenceIssueOfTheMonthData', getEmergingIssuesData);

router.get('/emergenceIssueOfTheMonthData/findbyname/:emergingIssue', getEmergingIssueDataByName);

// Add new emergenceIssueOfTheMonth to the DB
router.post('/emergenceIssueOfTheMonthData', createEmergingIssueData);

// Update a emergenceIssueOfTheMonth in the DB
router.put('/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthid/:id', updateEmergingIssueDataByID);

router.put('/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthnameen/:emergingIssue', updateEmergingIssueDataByEmergingIssueName);

// Delete a emergenceIssueOfTheMonth from the DB
router.delete('/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthid/:id', deleteEmergingIssueDataByID);

router.delete('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameenData/:politicalMappingEventName', deleteEmergingIssueDataByEmergingIssueName);


module.exports = router;