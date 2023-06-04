const {
  PoliticalMappingPartyGroupActorModel,
  PoliticalMappingPartyGroupActorSchema
} = require('../../Models/Political Mapping/political_map_party_group_model');

// Get a list of PoliticalMappingPartyGroupActorModel from the DB
const getPoliticalMappingPartyGroupActors = ((req, res, next) => {
  // Get all data
  PoliticalMappingPartyGroupActorModel.find({}).then(function (PoliticalMappingPartyGroupActorModel) {
    res.send(PoliticalMappingPartyGroupActorModel);
  });
})

const getPoliticalMappingPartyGroupActorByID = ((req, res, next) => {
  // Get all data
  PoliticalMappingPartyGroupActorModel.findOne({
    _id: req.params.id
  }).then(function (politicalMappingPartyGroupActor) {
    res.send(politicalMappingPartyGroupActor);
  });
})

const getPoliticalMappingPartyGroupActorByPartyGroupActorName = ((req, res, next) => {
  // Get all data
  PoliticalMappingPartyGroupActorModel.findOne({
    politicalMappingPartyGroupActorName: req.params.politicalMappingPartyGroupActorName
  }).then(function (politicalMappingPartyGroupActor) {
    res.send(politicalMappingPartyGroupActor);
  });
})

// Add new politicalMappingPartyGroupActor to the DB
const createPoliticalMappingPartyGroupActor = ((req, res, next) => {
  PoliticalMappingPartyGroupActorModel.create(req.body).then(function (politicalMappingPartyGroupActor) {
    res.send(politicalMappingPartyGroupActor);
  }).catch(next);

})

// Update a politicalMappingPartyGroupActor in the DB
const updatePoliticalMappingPartyGroupActorByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingPartyGroupActorModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingPartyGroupActorModel.findOne({
      _id: req.params.id
    }).then(function (politicalMappingPartyGroupActor) {
      res.send(politicalMappingPartyGroupActor);
    });
  });
})

const updatePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingPartyGroupActorModel.findOneAndUpdate({
    politicalMappingPartyGroupActorName: req.params.politicalMappingPartyGroupActorName
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingPartyGroupActorModel.findOne({
      politicalMappingPartyGroupActorName: req.params.politicalMappingPartyGroupActorName
    }).then(function (politicalMappingPartyGroupActor) {
      res.send(politicalMappingPartyGroupActor);
    });
  });
})


// Delete a politicalMappingPartyGroupActor from the DB
const deletePoliticalMappingPartyGroupActorByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingPartyGroupActorModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (politicalMappingPartyGroupActor) {
    res.send(politicalMappingPartyGroupActor);
  });
})

const deletePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingPartyGroupActorModel.findOneAndRemove({
    politicalMappingPartyGroupActorName: req.params.politicalMappingPartyGroupActorName
  }).then(function (politicalMappingPartyGroupActor) {
    res.send(politicalMappingPartyGroupActor);
  });
})


module.exports = {
  getPoliticalMappingPartyGroupActors: getPoliticalMappingPartyGroupActors,
  getPoliticalMappingPartyGroupActorByID: getPoliticalMappingPartyGroupActorByID,
  getPoliticalMappingPartyGroupActorByPartyGroupActorName: getPoliticalMappingPartyGroupActorByPartyGroupActorName,
  createPoliticalMappingPartyGroupActor: createPoliticalMappingPartyGroupActor,
  updatePoliticalMappingPartyGroupActorByID: updatePoliticalMappingPartyGroupActorByID,
  updatePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName: updatePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName,
  deletePoliticalMappingPartyGroupActorByID: deletePoliticalMappingPartyGroupActorByID,
  deletePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName: deletePoliticalMappingPartyGroupActorByPoliticalMappingPartyGroupActorName
}