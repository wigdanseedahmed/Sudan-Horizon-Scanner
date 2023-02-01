
////////////////////////////////////////////// IMPORTS //////////////////////////////////////////////


///////////////// MODELS /////////////////

const {
  EmergenceIssueOfTheMonthDataModel,
  EmergenceIssueOfTheMonthDataSchema
} = require('../../Models/Emergence Issue Of The Month/emergence_issue_of_the_month_data_model');



////////////////////////////////////////////// API CONTROLLER //////////////////////////////////////////////


// Get a list of emergingIssue from the DB
const getEmergingIssuesData = ((req, res, next) => {

  const sort = {source:1, sourceCategory: 1, emergenceIssue: 1};
  // Get all data
  EmergenceIssueOfTheMonthDataModel.find({}).sort(sort).then(function (emergingIssue) {
    res.send(emergingIssue);
  });
})

const getEmergingIssueDataByName = ((req, res, next) => {

  const sort = {source:1, sourceCategory: 1, emergenceIssue: 1};

  // Get data for one emergingIssue
  EmergenceIssueOfTheMonthDataModel.find({
    emergingIssue: req.params.emergingIssue
  }).sort(sort).then(function (emergingIssue) {
    res.send(emergingIssue);
  });
})


// Add new emergingIssue to the DB
const createEmergingIssueData = ((req, res, next) => {
  EmergenceIssueOfTheMonthDataModel.create(req.body).then(function (emergingIssue) {
    res.send(emergingIssue);
  }).catch(next);

})

// Update a emergingIssue in the DB
const updateEmergingIssueDataByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  EmergenceIssueOfTheMonthDataModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    EmergenceIssueOfTheMonthDataModel.findOne({
      _id: req.params.id
    }).then(function (emergingIssue) {
      res.send(emergingIssue);
    });
  });
})

const updateEmergingIssueDataByEmergingIssueName = ((req, res, next) => {
  //to access :id ---> req.params.id
  EmergenceIssueOfTheMonthDataModel.findOneAndUpdate({
    emergingIssue: req.params.emergingIssue
  }, {
    $set: req.body
  }).then(function () {
    EmergenceIssueOfTheMonthDataModel.findOne({
      CemergingIssue: req.params.emergingIssue
    }).then(function (emergingIssue) {
      res.send(emergingIssue);
    });
  });
})


// Delete a emergingIssue from the DB
const deleteEmergingIssueDataByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  EmergenceIssueOfTheMonthDataModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (emergingIssue) {
    res.send(emergingIssue);
  });
})

const deleteEmergingIssueDataByEmergingIssueName = ((req, res, next) => {
  //to access :id ---> req.params.id
  EmergenceIssueOfTheMonthDataModel.findOneAndRemove({
    emergingIssue: req.params.emergingIssue
  }).then(function (emergingIssue) {
    res.send(emergingIssue);
  });
})


module.exports = {
  getEmergingIssuesData: getEmergingIssuesData,
  getEmergingIssueDataByName: getEmergingIssueDataByName,
  createEmergingIssueData: createEmergingIssueData,
  updateEmergingIssueDataByID: updateEmergingIssueDataByID,
  updateEmergingIssueDataByEmergingIssueName: updateEmergingIssueDataByEmergingIssueName,
  deleteEmergingIssueDataByID: deleteEmergingIssueDataByID,
  deleteEmergingIssueDataByEmergingIssueName: deleteEmergingIssueDataByEmergingIssueName
}