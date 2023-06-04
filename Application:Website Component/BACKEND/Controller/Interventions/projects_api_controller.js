const {
  projectsModel,
  ProjectSchema
} = require('../../Models/interventions/projects_model');
const donorSchema = require('../../Models/interventions/donor_model');

// Get a list of projects from the DB
const getProjects = ((req, res, next) => {

  // Count the total donated amount for each project and update the projects
  projectsModel.find({}).then(function (projects) {
    //console.log(projects.length);
    for (let i = 0; i < projects.length; i++) {
      
    console.log(projects[i].projectName);
      var donorCount

      donorCount = projectsModel.aggregate([{
        "$project": {
          "count": {
            "$size": "$donor"
          }
        }
      }], function (err, donorCount) {
        if (err) throw err;
        var result = {};
        donorCount.forEach(function (item) {

          result = item.count;
        });

        projectsModel.findOne({projectName: projects[i].projectName})
          .populate('donor') // only works if we pushed refs to person.eventsAttended
          .exec(function (err, person) {
            if (err) return handleError(err);
            //console.log(person);


            var totalDonatedAmount = 0;

            for (let i = 0; i < result; i++) {
              //console.log(projects[i].donationAmount);
              totalDonatedAmount += person.donor[i].donationAmount
            }

            //console.log(totalDonatedAmount)

            projectsModel.findOneAndUpdate({
              projectName: person.projectName
            }, {
              $set: {
                totalDonatedAmount: totalDonatedAmount
              }
            }).then(function (updatedProject) {
              //console.log("updated");
              //res.send(updatedProject);
            });
          });
      });
    }
  });

  // Get all data
  projectsModel.find({}).then(function (projects) {
    res.send(projects);
  });
})

// Add new project to the DB
const createProject = ((req, res, next) => {
  projectsModel.create(req.body).then(function (project) {
    res.send(project);
  }).catch(next);

})

// Update a project in the DB
const updateProjectByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  projectsModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    projectsModel.findOne({
      _id: req.params.id
    }).then(function (project) {
      res.send(project);
    });
  });
})

const updateProjectByProjectName = ((req, res, next) => {
  //to access :id ---> req.params.id
  projectsModel.findOneAndUpdate({
    projectName: req.params.projectName
  }, {
    $set: req.body
  }).then(function () {
    projectsModel.findOne({
      projectName: req.params.projectName
    }).then(function (project) {
      res.send(project);
    });
  });
})


// Delete a project from the DB
const deleteProjectByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  projectsModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (project) {
    res.send(project);
  });
})

const deleteProjectByProjectName = ((req, res, next) => {
  //to access :id ---> req.params.id
  projectsModel.findOneAndRemove({
    projectName: req.params.projectName
  }).then(function (project) {
    res.send(project);
  });
})

// Filter projects based on themes
const filterProjectsBasedOnTheme = ((req, res) => {

  var query = {
    theme: {
      $in: [req.params.theme]
    },
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnRCTheme = ((req, res) => {

  var query = {
    theme: {
      $in: ['R_C']
    },
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnEETheme = ((req, res) => {

  var query = {
    theme: {
      $in: ['E_E']
    },
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnDETheme = ((req, res) => {

  var query = {
    theme: {
      $in: ['D_E']
    },
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnIDTheme = ((req, res) => {

  var query = {
    theme: {
      $in: ['I_D']
    },
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnHDTheme = ((req, res) => {

  var query = {
    theme: {
      $in: ['H_D']
    },
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnPSTheme = ((req, res) => {

  var query = {
    theme: {
      $in: ['P_S']
    },
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

// Filter projects based on themes and Locality

const filterProjectsBasedOnThemeandLocality = ((req, res) => {

  var query = {
    Locality_Name_EN: req.params.localityNameEN,
    theme: {
      $in: [req.params.theme]
    }
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnRCThemeandLocality = ((req, res) => {

  var query = {
    Locality_Name_EN: req.params.localityNameEN,
    theme: {
      $in: ['R_C']
    }
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnEEThemeandLocality = ((req, res) => {

  var query = {
    Locality_Name_EN: req.params.localityNameEN,
    theme: {
      $in: ['E_E']
    }
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnDEThemeandLocality = ((req, res) => {

  var query = {
    Locality_Name_EN: req.params.localityNameEN,
    theme: {
      $in: ['D_E']
    }
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnIDThemeandLocality = ((req, res) => {

  var query = {
    Locality_Name_EN: req.params.localityNameEN,
    theme: {
      $in: ['I_D', ]
    }
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnHDThemeandLocality = ((req, res) => {

  var query = {
    Locality_Name_EN: req.params.localityNameEN,
    theme: {
      $in: ['H_D']
    }
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

const filterProjectsBasedOnPSThemeandLocality = ((req, res) => {

  var query = {
    Locality_Name_EN: req.params.localityNameEN,
    theme: {
      $in: ['P_S']
    }
  };

  projectsModel
    .find(query).then(function (project) {
      res.send(project);
    });
})

// Count total donated amount

const countTotalDonationAmountBasedOnProjectName = ((req, res) => {


  var donorCount

  donorCount = projectsModel.aggregate([{
    "$project": {
      "count": {
        "$size": "$donor"
      }
    }
  }], function (err, donorCount) {
    if (err) throw err;
    var result = {};
    donorCount.forEach(function (item) {

      result = item.count;
    });
    console.log(result)

    projectsModel.findOne({
        projectName: req.params.projectName
      })
      .populate('donor') // only works if we pushed refs to person.eventsAttended
      .exec(function (err, person) {
        if (err) return handleError(err);
        //console.log(person);


        var totalDonatedAmount = 0;

        for (let i = 0; i < result; i++) {
          //console.log(projects[i].donationAmount);
          totalDonatedAmount += person.donor[i].donationAmount
        }

        //console.log(totalDonatedAmount)

        projectsModel.findOneAndUpdate({
          projectName: person.projectName
        }, {
          $set: {
            totalDonatedAmount: totalDonatedAmount
          }
        }).then(function (project) {
          res.send(project);
        });
      });
  });

})

const countTotalDonationAmount = ((req, res) => {


  // Count the total donated amount for each project and update the projects
  projectsModel.find({}).then(function (projects) {
    //console.log(projects.length);
    for (let i = 0; i < projects.length; i++) {
      
    console.log(projects[i].projectName);
      var donorCount

      donorCount = projectsModel.aggregate([{
        "$project": {
          "count": {
            "$size": "$donor"
          }
        }
      }], function (err, donorCount) {
        if (err) throw err;
        var result = {};
        donorCount.forEach(function (item) {

          result = item.count;
        });

        projectsModel.findOne({projectName: projects[i].projectName})
          .populate('donor') // only works if we pushed refs to person.eventsAttended
          .exec(function (err, person) {
            if (err) return handleError(err);
            //console.log(person);


            var totalDonatedAmount = 0;

            for (let i = 0; i < result; i++) {
              //console.log(projects[i].donationAmount);
              totalDonatedAmount += person.donor[i].donationAmount
            }

            //console.log(totalDonatedAmount)

            projectsModel.findOneAndUpdate({
              projectName: person.projectName
            }, {
              $set: {
                totalDonatedAmount: totalDonatedAmount
              }
            }).then(function (updatedProject) {
              console.log("updated");
              //res.send(updatedProject);
            });
          });
      });
    }
  }).then(function (updatedProject) {
    //console.log("updated");
    res.send("done");
  });;

})

module.exports = {
  getProjects: getProjects,
  createProject: createProject,
  updateProjectByID: updateProjectByID,
  updateProjectByProjectName: updateProjectByProjectName,
  deleteProjectByID: deleteProjectByID,
  deleteProjectByProjectName: deleteProjectByProjectName,
  filterProjectsBasedOnTheme: filterProjectsBasedOnTheme,
  filterProjectsBasedOnRCTheme: filterProjectsBasedOnRCTheme,
  filterProjectsBasedOnEETheme: filterProjectsBasedOnEETheme,
  filterProjectsBasedOnDETheme: filterProjectsBasedOnDETheme,
  filterProjectsBasedOnIDTheme: filterProjectsBasedOnIDTheme,
  filterProjectsBasedOnHDTheme: filterProjectsBasedOnHDTheme,
  filterProjectsBasedOnPSTheme: filterProjectsBasedOnPSTheme,
  filterProjectsBasedOnThemeandLocality: filterProjectsBasedOnThemeandLocality,
  filterProjectsBasedOnRCThemeandLocality: filterProjectsBasedOnRCThemeandLocality,
  filterProjectsBasedOnEEThemeandLocality: filterProjectsBasedOnEEThemeandLocality,
  filterProjectsBasedOnDEThemeandLocality: filterProjectsBasedOnDEThemeandLocality,
  filterProjectsBasedOnIDThemeandLocality: filterProjectsBasedOnIDThemeandLocality,
  filterProjectsBasedOnHDThemeandLocality: filterProjectsBasedOnHDThemeandLocality,
  filterProjectsBasedOnPSThemeandLocality: filterProjectsBasedOnPSThemeandLocality,
  countTotalDonationAmountBasedOnProjectName: countTotalDonationAmountBasedOnProjectName,
  countTotalDonationAmount: countTotalDonationAmount
}