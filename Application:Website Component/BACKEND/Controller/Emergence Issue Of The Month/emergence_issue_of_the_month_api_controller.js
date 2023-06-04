////////////////////////////////////////////// IMPORTS //////////////////////////////////////////////


///////////////// MODELS /////////////////
const {
  EmergenceIssueOfTheMonthModel,
  EmergenceIssueOfTheMonthSchema
} = require('../../Models/Emergence Issue Of The Month/emergence_issue_of_the_month_model');

const {
  EmergenceIssueOfTheMonthDataModel,
  EmergenceIssueOfTheMonthDataSchema
} = require('../../Models/Emergence Issue Of The Month/emergence_issue_of_the_month_data_model');


///////////////// FUNCTIONS /////////////////
const {
  emergingIssueComponentsCalculation
} = require('../../Funtcions/Emergence Issue Of The Month/emergence_issue_of_month_functions');


////////////////////////////////////////////// API CONTROLLER //////////////////////////////////////////////


// Get a list of emergingIssue from the DB
const getEmergingIssues = ((req, res, next) => {

   // 1. Count the number of positive data, neutral data, and negative data

   EmergenceIssueOfTheMonthModel.find({}).then(
    emergingIssueComponentsCalculation
  )

  const sort = {
    repetition: -1,
    time: -1,
    emergingIssue: -1
  };

  // Get all data
  EmergenceIssueOfTheMonthModel.find({}).sort(sort).then(function (emergingIssue) {
    res.send(emergingIssue);
  });
})

const getEmergingIssueByName = ((req, res, next) => {

    // 1. Count the number of positive data, neutral data, and negative data

    EmergenceIssueOfTheMonthModel.find({}).then(
      emergingIssueComponentsCalculation
    )
  

  const sort = {
    repetition: -1,
    time: -1,
    emergingIssue: -1
  };

  // Get data for one emergingIssue
  EmergenceIssueOfTheMonthModel.find({
    emergingIssue: req.params.emergingIssue
  }).sort(sort).then(function (emergingIssue) {
    res.send(emergingIssue);
  });
})


// Add new emergingIssue to the DB
const createEmergingIssue = ((req, res, next) => {

  // 1. Count the number of positive data, neutral data, and negative data

  EmergenceIssueOfTheMonthModel.find({}).then(
    emergingIssueComponentsCalculation
  )


  EmergenceIssueOfTheMonthModel.create(req.body).then(function (emergingIssue) {
    res.send(emergingIssue);
  }).catch(next);

})

// Update a emergingIssue in the DB
const updateEmergingIssueByID = ((req, res, next) => {

    // 1. Count the number of positive data, neutral data, and negative data

    EmergenceIssueOfTheMonthModel.find({}).then(
      emergingIssueComponentsCalculation
    )
  

  //to access :id ---> req.params.id
  EmergenceIssueOfTheMonthModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    EmergenceIssueOfTheMonthModel.findOne({
      _id: req.params.id
    }).then(function (emergingIssue) {
      res.send(emergingIssue);
    });
  });
})

const updateEmergingIssueByEmergingIssueName = ((req, res, next) => {

  // 1. Count the number of positive data, neutral data, and negative data

  EmergenceIssueOfTheMonthModel.find({}).then(
    emergingIssueComponentsCalculation
  )


  //to access :id ---> req.params.id
  EmergenceIssueOfTheMonthModel.findOneAndUpdate({
    emergingIssue: req.params.emergingIssue
  }, {
    $set: req.body
  }).then(function () {
    EmergenceIssueOfTheMonthModel.findOne({
      CemergingIssue: req.params.emergingIssue
    }).then(function (emergingIssue) {
      res.send(emergingIssue);
    });
  });
})


// Delete a emergingIssue from the DB
const deleteEmergingIssueByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  EmergenceIssueOfTheMonthModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (emergingIssue) {
    res.send(emergingIssue);
  });
})

const deleteEmergingIssueByEmergingIssueName = ((req, res, next) => {
  //to access :id ---> req.params.id
  EmergenceIssueOfTheMonthModel.findOneAndRemove({
    emergingIssue: req.params.emergingIssue
  }).then(function (emergingIssue) {
    res.send(emergingIssue);
  });
})


module.exports = {
  getEmergingIssues: getEmergingIssues,
  getEmergingIssueByName: getEmergingIssueByName,
  createEmergingIssue: createEmergingIssue,
  updateEmergingIssueByID: updateEmergingIssueByID,
  updateEmergingIssueByEmergingIssueName: updateEmergingIssueByEmergingIssueName,
  deleteEmergingIssueByID: deleteEmergingIssueByID,
  deleteEmergingIssueByEmergingIssueName: deleteEmergingIssueByEmergingIssueName
}