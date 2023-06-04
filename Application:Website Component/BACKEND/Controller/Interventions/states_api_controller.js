const {
    statesModel, 
    StateSchema
} = require('../../Models/interventions/state_model');

const {
    projectsModel,
    ProjectSchema
  } = require('../../Models/interventions/projects_model');

// Get a list of states from the DB
const getStates = ((req, res, next) => {
// Count number of projects per theme for each state
statesModel.find().then(function (state) {
    for (let i = 0; i < state.length; i++) {
        
        let map = new Map();
      // Get all data
      projectsModel.find({
        State_Name_EN: state[i].State_Name_EN
      }).then(function (states) {
          if (states.length > 0) {

          async function countProjectsBasedonTheme() {
            try {
              // Find the number of documents that match the specified query, and print out the count.
              map['R_C'] = await projectsModel.countDocuments({
                $and: [{State_Name_EN: {
                  $eq: state[i].State_Name_EN
                }},
                {theme: {
                  $in: ['R_C']
                }}]
              });
              map['E_E'] = await projectsModel.countDocuments({
                $and: [{State_Name_EN: {
                  $eq: state[i].State_Name_EN
                }},
                {theme: {
                  $in: ['E_E']
                }}]
              });
              map['D_E'] = await projectsModel.countDocuments({
                $and: [{State_Name_EN: {
                  $eq: state[i].State_Name_EN
                }},
                {theme: {
                  $in: ['D_E']
                }}]
              });
              map['I_D'] = await projectsModel.countDocuments({
                $and: [{State_Name_EN: {
                  $eq: state[i].State_Name_EN
                }},
                {theme: {
                  $in: ['I_D']
                }}]
              });
              map['H_D'] = await projectsModel.countDocuments({
                $and: [{State_Name_EN: {
                  $eq: state[i].State_Name_EN
                }},
                {theme: {
                  $in: ['H_D']
                }}]
              });
              map['P_S'] = await projectsModel.countDocuments({
                $and: [{State_Name_EN: {
                  $eq: state[i].State_Name_EN
                }},
                {theme: {
                  $in: ['P_S']
                }}]
              });
              ///console.log(map);

              // Sort Keys from map and save them arrays
              let sortable = Object.keys(map).sort((a, b) => {
                return map[b] - map[a];
              });
              ///console.log(sortable);


              // Check to see if map contains 0 then save value before
              ///console.log(Object.values(map).includes(0));
              var noProjects;
              var leastProjects;
              var mostProjects;

              if (await Object.values(map).includes(0)) {
                //console.log(Object.values(map).includes(0));
                noProjects = sortable[sortable.length - 1];
                leastProjects = sortable[sortable.length - 2];
                mostProjects = sortable[0];
              } else {
                {
                  noProjects = "";
                  leastProjects = sortable[sortable.length - 1];
                  mostProjects = sortable[0];
                }
              }

              await statesModel.findOneAndUpdate({
                State_Name_EN: state[i].State_Name_EN
              }, {
                $set: {
                  "Most_Intervention_Type": mostProjects,
                  "Least_Intervention_Type": leastProjects,
                  "No_Intervention_Type": noProjects,
                }
              }).then(function () {
                 statesModel.findOne({
                  State_Name_EN: state[i].State_Name_EN
                }).then(function (state) {
                  //res.send(state);
                });
              });
              
              
              console.log(`${state[i].State_Name_EN}:\n map: ${Object.values(map)}, Conatins zero: ${Object.values(map).includes(0)}, no Projects: ${noProjects}, least Projects: ${leastProjects}, most Projects: ${mostProjects}`);
            
            } catch (err) {
              res.send('Error: ' + err);
            }

          }
          countProjectsBasedonTheme().catch(console.dir);

        } else {
          statesModel.findOneAndUpdate({
            State_Name_EN: state[i].State_Name_EN
          }, {
            $set: {
              "Most_Intervention_Type": "",
              "Least_Intervention_Type": "",
              "No_Intervention_Type": "",
            }
          });
        }
      });
    }
    //res.send("Done");

  });


    // Get all data
    statesModel.find({}).then(function (states) {
        res.send(states);
    });
})

// Add new state to the DB
const createState = ((req, res, next) => {
    statesModel.create(req.body).then(function (state) {
        res.send(state);
    }).catch(next);

})

// Update a state in the DB
const updateStateByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    statesModel.findByIdAndUpdate({ _id: req.params.id }, {$set:req.body}).then(function () {
        statesModel.findOne({ _id: req.params.id }).then(function (state) {
            res.send(state);
        });
    });
})

const updateStateByStateNameEN = ((req, res, next) => {
    //to access :id ---> req.params.id
    statesModel.findOneAndUpdate({ State_Name_EN: req.params.stateNameEN }, {$set:req.body}).then(function () {
        statesModel.findOne({ State_Name_EN: req.params.stateNameEN }).then(function (state) {
            res.send(state);
        });
    });
})

// Delete a state from the DB
const deleteStateByID = ((req, res, next) => {
    //to access :id ---> req.params.id
    statesModel.findByIdAndRemove({ _id: req.params.id }).then(function (state) {
        res.send(state);
    });
})

const deleteStateByStateNameEN = ((req, res, next) => {
    //to access :id ---> req.params.id
    statesModel.findOneAndRemove({ State_Name_EN: req.params.stateNameEN }).then(function (state) {
        res.send(state);
    });
})

const countMostInterventionTypePerState = ((req, res) => {
   
  
    // Count number of projects per theme for each state
    statesModel.find().then(function (state) {
      for (let i = 0; i < state.length; i++) {
          console.log(state[i].State_Name_EN);
          let map = new Map();
        // Get all data
        projectsModel.find({
          State_Name_EN: state[i].State_Name_EN
        }).then(function (states) {
            if (states.length > 0) {
  
            async function countProjectsBasedonTheme() {
              try {
                // Find the number of documents that match the specified query, and print out the count.
                map['R_C'] = await projectsModel.countDocuments({
                  $and: [{State_Name_EN: {
                    $eq: state[i].State_Name_EN
                  }},
                  {theme: {
                    $in: ['R_C']
                  }}]
                });
                map['E_E'] = await projectsModel.countDocuments({
                  $and: [{State_Name_EN: {
                    $eq: state[i].State_Name_EN
                  }},
                  {theme: {
                    $in: ['E_E']
                  }}]
                });
                map['D_E'] = await projectsModel.countDocuments({
                  $and: [{State_Name_EN: {
                    $eq: state[i].State_Name_EN
                  }},
                  {theme: {
                    $in: ['D_E']
                  }}]
                });
                map['I_D'] = await projectsModel.countDocuments({
                  $and: [{State_Name_EN: {
                    $eq: state[i].State_Name_EN
                  }},
                  {theme: {
                    $in: ['I_D']
                  }}]
                });
                map['H_D'] = await projectsModel.countDocuments({
                  $and: [{State_Name_EN: {
                    $eq: state[i].State_Name_EN
                  }},
                  {theme: {
                    $in: ['H_D']
                  }}]
                });
                map['P_S'] = await projectsModel.countDocuments({
                  $and: [{State_Name_EN: {
                    $eq: state[i].State_Name_EN
                  }},
                  {theme: {
                    $in: ['P_S']
                  }}]
                });
                ///console.log(map);
  
                // Sort Keys from map and save them arrays
                let sortable = Object.keys(map).sort((a, b) => {
                  return map[b] - map[a];
                });
                ///console.log(sortable);
  
  
                // Check to see if map contains 0 then save value before
                ///console.log(Object.values(map).includes(0));
                var noProjects;
                var leastProjects;
                var mostProjects;
  
                if (await Object.values(map).includes(0)) {
                  //console.log(Object.values(map).includes(0));
                  noProjects = sortable[sortable.length - 1];
                  leastProjects = sortable[sortable.length - 2];
                  mostProjects = sortable[0];
                } else {
                  {
                    noProjects = "";
                    leastProjects = sortable[sortable.length - 1];
                    mostProjects = sortable[0];
                  }
                }
  
                await statesModel.findOneAndUpdate({
                  State_Name_EN: state[i].State_Name_EN
                }, {
                  $set: {
                    "Most_Intervention_Type": mostProjects,
                    "Least_Intervention_Type": leastProjects,
                    "No_Intervention_Type": noProjects,
                  }
                }).then(function () {
                   statesModel.findOne({
                    State_Name_EN: state[i].State_Name_EN
                  }).then(function (state) {
                    //res.send(state);
                  });
                });
                
                
                console.log(`${state[i].State_Name_EN}:\n map: ${Object.values(map)}, Conatins zero: ${Object.values(map).includes(0)}, no Projects: ${noProjects}, least Projects: ${leastProjects}, most Projects: ${mostProjects}`);
              
              } catch (err) {
                res.send('Error: ' + err);
              }
  
            }
            countProjectsBasedonTheme().catch(console.dir);
  
          } else {
            statesModel.findOneAndUpdate({
              State_Name_EN: state[i].State_Name_EN
            }, {
              $set: {
                "Most_Intervention_Type": "",
                "Least_Intervention_Type": "",
                "No_Intervention_Type": "",
              }
            }).then(function () {
              statesModel.findOne({
                State_Name_EN: req.params.State_Name_EN
              }).then(function (state) {
                //res.send(state);
              });
            });
          }
          //res.send(states);
        });
      }
      res.send("Done");
  
    });
  
  
  })
  

module.exports = {
    getStates: getStates,
    createState: createState,
    updateStateByID: updateStateByID,
    updateStateByStateNameEN: updateStateByStateNameEN,
    deleteStateByID: deleteStateByID,
    deleteStateByStateNameEN: deleteStateByStateNameEN,
    countMostInterventionTypePerState: countMostInterventionTypePerState
}