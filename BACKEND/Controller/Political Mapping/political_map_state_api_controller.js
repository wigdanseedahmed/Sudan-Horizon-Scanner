const {
  PoliticalMappingStateModel,
  PoliticalMappingStateSchema
} = require('../../Models/Political Mapping/political_map_state_model');

// Get a list of PoliticalMappingStateModel from the DB
const getPoliticalMappingStates = ((req, res, next) => {
  // Get all data
  PoliticalMappingStateModel.find({}).then(function (PoliticalMappingStateModel) {
    res.send(PoliticalMappingStateModel);
  });
})

const getPoliticalMappingStateByID = ((req, res, next) => {
  // Get all data
  PoliticalMappingStateModel.findOne({
    _id: req.params.id
  }).then(function (politicalMappingState) {
    res.send(politicalMappingState);
  });
})

const getPoliticalMappingStateByStateName = ((req, res, next) => {
  // Get all data
  PoliticalMappingStateModel.findOne({
    politicalMappingStateName: req.params.politicalMappingStateName
  }).then(function (politicalMappingState) {
    res.send(politicalMappingState);
  });
})

// Add new politicalMappingState to the DB
const createPoliticalMappingState = ((req, res, next) => {
  PoliticalMappingStateModel.create(req.body).then(function (politicalMappingState) {
    res.send(politicalMappingState);
  }).catch(next);

})

// Update a politicalMappingState in the DB
const updatePoliticalMappingStateByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingStateModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingStateModel.findOne({
      _id: req.params.id
    }).then(function (politicalMappingState) {
      res.send(politicalMappingState);
    });
  });
})

const updatePoliticalMappingStateByPoliticalMappingStateName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingStateModel.findOneAndUpdate({
    politicalMappingStateName: req.params.politicalMappingStateName
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingStateModel.findOne({
      politicalMappingStateName: req.params.politicalMappingStateName
    }).then(function (politicalMappingState) {
      res.send(politicalMappingState);
    });
  });
})


// Delete a politicalMappingState from the DB
const deletePoliticalMappingStateByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingStateModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (politicalMappingState) {
    res.send(politicalMappingState);
  });
})

const deletePoliticalMappingStateByPoliticalMappingStateName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingStateModel.findOneAndRemove({
    politicalMappingStateName: req.params.politicalMappingStateName
  }).then(function (politicalMappingState) {
    res.send(politicalMappingState);
  });
})


module.exports = {
  getPoliticalMappingStates: getPoliticalMappingStates,
  getPoliticalMappingStateByID: getPoliticalMappingStateByID,
  getPoliticalMappingStateByStateName: getPoliticalMappingStateByStateName,
  createPoliticalMappingState: createPoliticalMappingState,
  updatePoliticalMappingStateByID: updatePoliticalMappingStateByID,
  updatePoliticalMappingStateByPoliticalMappingStateName: updatePoliticalMappingStateByPoliticalMappingStateName,
  deletePoliticalMappingStateByID: deletePoliticalMappingStateByID,
  deletePoliticalMappingStateByPoliticalMappingStateName: deletePoliticalMappingStateByPoliticalMappingStateName
}