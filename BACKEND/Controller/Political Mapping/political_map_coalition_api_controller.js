const {
  PoliticalMappingCoalitionModel,
  PoliticalMappingCoalitionSchema
} = require('../../Models/Political Mapping/political_map_coalition_model');

// Get a list of PoliticalMappingCoalitionModel from the DB
const getPoliticalMappingCoalitions = ((req, res, next) => {
  // Get all data
  PoliticalMappingCoalitionModel.find({}).then(function (PoliticalMappingCoalitionModel) {
    res.send(PoliticalMappingCoalitionModel);
  });
})

const getPoliticalMappingCoalitionByID = ((req, res, next) => {
  // Get all data
  PoliticalMappingCoalitionModel.findOne({
    _id: req.params.id
  }).then(function (politicalMappingCoalition) {
    res.send(politicalMappingCoalition);
  });
})

const getPoliticalMappingCoalitionByCoalitionName = ((req, res, next) => {
  // Get all data
  PoliticalMappingCoalitionModel.findOne({
    politicalMappingCoalitionName: req.params.politicalMappingCoalitionName
  }).then(function (politicalMappingCoalition) {
    res.send(politicalMappingCoalition);
  });
})

// Add new politicalMappingCoalition to the DB
const createPoliticalMappingCoalition = ((req, res, next) => {
  PoliticalMappingCoalitionModel.create(req.body).then(function (politicalMappingCoalition) {
    res.send(politicalMappingCoalition);
  }).catch(next);

})

// Update a politicalMappingCoalition in the DB
const updatePoliticalMappingCoalitionByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingCoalitionModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingCoalitionModel.findOne({
      _id: req.params.id
    }).then(function (politicalMappingCoalition) {
      res.send(politicalMappingCoalition);
    });
  });
})

const updatePoliticalMappingCoalitionByPoliticalMappingCoalitionName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingCoalitionModel.findOneAndUpdate({
    politicalMappingCoalitionName: req.params.politicalMappingCoalitionName
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingCoalitionModel.findOne({
      politicalMappingCoalitionName: req.params.politicalMappingCoalitionName
    }).then(function (politicalMappingCoalition) {
      res.send(politicalMappingCoalition);
    });
  });
})


// Delete a politicalMappingCoalition from the DB
const deletePoliticalMappingCoalitionByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingCoalitionModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (politicalMappingCoalition) {
    res.send(politicalMappingCoalition);
  });
})

const deletePoliticalMappingCoalitionByPoliticalMappingCoalitionName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingCoalitionModel.findOneAndRemove({
    politicalMappingCoalitionName: req.params.politicalMappingCoalitionName
  }).then(function (politicalMappingCoalition) {
    res.send(politicalMappingCoalition);
  });
})


module.exports = {
  getPoliticalMappingCoalitions: getPoliticalMappingCoalitions,
  getPoliticalMappingCoalitionByID: getPoliticalMappingCoalitionByID,
  getPoliticalMappingCoalitionByCoalitionName: getPoliticalMappingCoalitionByCoalitionName,
  createPoliticalMappingCoalition: createPoliticalMappingCoalition,
  updatePoliticalMappingCoalitionByID: updatePoliticalMappingCoalitionByID,
  updatePoliticalMappingCoalitionByPoliticalMappingCoalitionName: updatePoliticalMappingCoalitionByPoliticalMappingCoalitionName,
  deletePoliticalMappingCoalitionByID: deletePoliticalMappingCoalitionByID,
  deletePoliticalMappingCoalitionByPoliticalMappingCoalitionName: deletePoliticalMappingCoalitionByPoliticalMappingCoalitionName
}