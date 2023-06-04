const {
  PoliticalMappingIndividualActorModel,
  PoliticalMappingIndividualActorSchema
} = require('../../Models/Political Mapping/political_map_individual_model');

// Get a list of PoliticalMappingIndividualActorModel from the DB
const getPoliticalMappingIndividualActors = ((req, res, next) => {
  // Get all data
  PoliticalMappingIndividualActorModel.find({}).then(function (PoliticalMappingIndividualActorModel) {
    res.send(PoliticalMappingIndividualActorModel);
  });
})

const getPoliticalMappingIndividualActorByID = ((req, res, next) => {
  // Get all data
  PoliticalMappingIndividualActorModel.findOne({
    _id: req.params.id
  }).then(function (politicalMappingIndividualActor) {
    res.send(politicalMappingIndividualActor);
  });
})

const getPoliticalMappingIndividualActorByIndividualActorName = ((req, res, next) => {
  // Get all data
  PoliticalMappingIndividualActorModel.findOne({
    politicalMappingIndividualActorName: req.params.politicalMappingIndividualActorName
  }).then(function (politicalMappingIndividualActor) {
    res.send(politicalMappingIndividualActor);
  });
})

// Add new politicalMappingIndividualActor to the DB
const createPoliticalMappingIndividualActor = ((req, res, next) => {
  PoliticalMappingIndividualActorModel.create(req.body).then(function (politicalMappingIndividualActor) {
    res.send(politicalMappingIndividualActor);
  }).catch(next);

})

// Update a politicalMappingIndividualActor in the DB
const updatePoliticalMappingIndividualActorByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingIndividualActorModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingIndividualActorModel.findOne({
      _id: req.params.id
    }).then(function (politicalMappingIndividualActor) {
      res.send(politicalMappingIndividualActor);
    });
  });
})

const updatePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingIndividualActorModel.findOneAndUpdate({
    politicalMappingIndividualActorName: req.params.politicalMappingIndividualActorName
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingIndividualActorModel.findOne({
      politicalMappingIndividualActorName: req.params.politicalMappingIndividualActorName
    }).then(function (politicalMappingIndividualActor) {
      res.send(politicalMappingIndividualActor);
    });
  });
})


// Delete a politicalMappingIndividualActor from the DB
const deletePoliticalMappingIndividualActorByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingIndividualActorModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (politicalMappingIndividualActor) {
    res.send(politicalMappingIndividualActor);
  });
})

const deletePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingIndividualActorModel.findOneAndRemove({
    politicalMappingIndividualActorName: req.params.politicalMappingIndividualActorName
  }).then(function (politicalMappingIndividualActor) {
    res.send(politicalMappingIndividualActor);
  });
})


module.exports = {
  getPoliticalMappingIndividualActors: getPoliticalMappingIndividualActors,
  getPoliticalMappingIndividualActorByID: getPoliticalMappingIndividualActorByID,
  getPoliticalMappingIndividualActorByIndividualActorName: getPoliticalMappingIndividualActorByIndividualActorName,
  createPoliticalMappingIndividualActor: createPoliticalMappingIndividualActor,
  updatePoliticalMappingIndividualActorByID: updatePoliticalMappingIndividualActorByID,
  updatePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName: updatePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName,
  deletePoliticalMappingIndividualActorByID: deletePoliticalMappingIndividualActorByID,
  deletePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName: deletePoliticalMappingIndividualActorByPoliticalMappingIndividualActorName
}