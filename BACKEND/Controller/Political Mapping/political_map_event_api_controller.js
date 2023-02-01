const {
  PoliticalMappingEventModel,
  PoliticalMappingEventSchema
} = require('../../Models/Political Mapping/political_map_event_model');

// Get a list of PoliticalMappingEventModel from the DB
const getPoliticalMappingEvents = ((req, res, next) => {
  // Get all data
  PoliticalMappingEventModel.find({}).then(function (PoliticalMappingEventModel) {
    res.send(PoliticalMappingEventModel);
  });
})

const getPoliticalMappingEventByID = ((req, res, next) => {
  // Get all data
  PoliticalMappingEventModel.findOne({
    _id: req.params.id
  }).then(function (politicalMappingEvent) {
    res.send(politicalMappingEvent);
  });
})

const getPoliticalMappingEventByEventName = ((req, res, next) => {
  // Get all data
  PoliticalMappingEventModel.findOne({
    politicalMappingEventName: req.params.politicalMappingEventName
  }).then(function (politicalMappingEvent) {
    res.send(politicalMappingEvent);
  });
})

// Add new politicalMappingEvent to the DB
const createPoliticalMappingEvent = ((req, res, next) => {
  PoliticalMappingEventModel.create(req.body).then(function (politicalMappingEvent) {
    res.send(politicalMappingEvent);
  }).catch(next);

})

// Update a politicalMappingEvent in the DB
const updatePoliticalMappingEventByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingEventModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingEventModel.findOne({
      _id: req.params.id
    }).then(function (politicalMappingEvent) {
      res.send(politicalMappingEvent);
    });
  });
})

const updatePoliticalMappingEventByPoliticalMappingEventName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingEventModel.findOneAndUpdate({
    politicalMappingEventName: req.params.politicalMappingEventName
  }, {
    $set: req.body
  }).then(function () {
    PoliticalMappingEventModel.findOne({
      politicalMappingEventName: req.params.politicalMappingEventName
    }).then(function (politicalMappingEvent) {
      res.send(politicalMappingEvent);
    });
  });
})


// Delete a politicalMappingEvent from the DB
const deletePoliticalMappingEventByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingEventModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (politicalMappingEvent) {
    res.send(politicalMappingEvent);
  });
})

const deletePoliticalMappingEventByPoliticalMappingEventName = ((req, res, next) => {
  //to access :id ---> req.params.id
  PoliticalMappingEventModel.findOneAndRemove({
    politicalMappingEventName: req.params.politicalMappingEventName
  }).then(function (politicalMappingEvent) {
    res.send(politicalMappingEvent);
  });
})


module.exports = {
  getPoliticalMappingEvents: getPoliticalMappingEvents,
  getPoliticalMappingEventByID: getPoliticalMappingEventByID,
  getPoliticalMappingEventByEventName: getPoliticalMappingEventByEventName,
  createPoliticalMappingEvent: createPoliticalMappingEvent,
  updatePoliticalMappingEventByID: updatePoliticalMappingEventByID,
  updatePoliticalMappingEventByPoliticalMappingEventName: updatePoliticalMappingEventByPoliticalMappingEventName,
  deletePoliticalMappingEventByID: deletePoliticalMappingEventByID,
  deletePoliticalMappingEventByPoliticalMappingEventName: deletePoliticalMappingEventByPoliticalMappingEventName
}