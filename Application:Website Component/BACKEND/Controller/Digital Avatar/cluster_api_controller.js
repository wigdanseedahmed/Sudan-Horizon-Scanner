const {
  clustersModel,
  ClusterSigma
} = require('../../Models/Digital Avatar/cluster_model');


// Get a list of cluster from the DB
const getClusters = ((req, res, next) => {

  // Count number of documents per cluster 
  async function countDocumentsBasedonClusters() {
    try {
      // Find the number of documents that match the specified query, and print out the count.
      const countAll = await clustersModel.countDocuments({});

      const countAgricultureClusters = await clustersModel.countDocuments({
        cluster: "Agriculture"
        
      });

      const countConflictClusters = await clustersModel.countDocuments({
        cluster: "Conflict" 
      });

      const countEconomicClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Economic"
        }
      });

      const countEducationClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Education"
        }
      });

      const countEnvironmentClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Environment"
        }
      });

      const countFoodSecurityAndNutritiontClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Food Security and Nutrition"
        }
      });

      const countGenderClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Gender"
        }
      });

      const countHealthClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Health"
        }
      });

      const countInfrastructureClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Infrastructure"
        }
      });

      const countPopulationClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Population"
        }
      });

      const countPovertyClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Poverty"
        }
      });

      
      console.log(`All: ${countAll}
      Agriculture: ${countAgricultureClusters}
      Conflict: ${countConflictClusters},
      Economic: ${countEconomicClusters}
      Education: ${countEducationClusters}
      Environment: ${countEnvironmentClusters}
      Food Security and Nutrition: ${countFoodSecurityAndNutritiontClusters}
      Gender: ${countGenderClusters},
      Health: ${countHealthClusters}
      Infrastructure: ${countInfrastructureClusters}
      Population: ${countPopulationClusters}
      Poverty: ${countPovertyClusters}`);
    

    } catch (err) {
      res.send('Error: ' + err);
    }

  }
  countDocumentsBasedonClusters().catch(console.dir);


  // Get all data
  clustersModel.find({}).then(function (cluster) {
    res.send(cluster);
  });
})

const getCluster = ((req, res, next) => {

  // Get data for one cluster
  clustersModel.find({
    cluster: req.params.cluster
  }).then(function (cluster) {
    res.send(cluster);
  });
})

const getClusterBasedOnIndicator = ((req, res, next) => {

  // Get data for one cluster
  clustersModel.find({
    cluster: req.params.cluster,
    indicators: req.params.indicators
  }).then(function (cluster) {
    res.send(cluster);
  });
})

// Add new cluster to the DB
const createCluster = ((req, res, next) => {
  clustersModel.create(req.body).then(function (cluster) {
    res.send(cluster);
  }).catch(next);

})

// Update a cluster in the DB
const updateClusterByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  clustersModel.findByIdAndUpdate({
    _id: req.params.id
  }, {
    $set: req.body
  }).then(function () {
    clustersModel.findOne({
      _id: req.params.id
    }).then(function (cluster) {
      res.send(cluster);
    });
  });
})

const updateClusterByClusterName = ((req, res, next) => {
  //to access :id ---> req.params.id
  clustersModel.findOneAndUpdate({
    cluster: req.params.cluster
  }, {
    $set: req.body
  }).then(function () {
    clustersModel.findOne({
      Ccluster: req.params.cluster
    }).then(function (cluster) {
      res.send(cluster);
    });
  });
})


// Delete a cluster from the DB
const deleteClusterByID = ((req, res, next) => {
  //to access :id ---> req.params.id
  clustersModel.findByIdAndRemove({
    _id: req.params.id
  }).then(function (cluster) {
    res.send(cluster);
  });
})

const deleteClusterByClusterName = ((req, res, next) => {
  //to access :id ---> req.params.id
  clustersModel.findOneAndRemove({
    cluster: req.params.cluster
  }).then(function (cluster) {
    res.send(cluster);
  });
})

// Count cluster documents from the DB
const getCountDocumentsPerCluster = ((req, res, next) => {

  // Count number of documents per cluster 
  async function countDocumentsBasedonClusters() {
    try {
      // Find the number of documents that match the specified query, and print out the count.
      const countAll = await clustersModel.countDocuments({});

      const countAgricultureClusters = await clustersModel.countDocuments({
        cluster: "Agriculture"
        
      });

      const countConflictClusters = await clustersModel.countDocuments({
        cluster: "Conflict" 
      });

      const countEconomicClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Economic"
        }
      });

      const countEducationClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Education"
        }
      });

      const countEnvironmentClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Environment"
        }
      });

      const countFoodSecurityAndNutritiontClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Food Security and Nutrition"
        }
      });

      const countGenderClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Gender"
        }
      });

      const countHealthClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Health"
        }
      });

      const countInfrastructureClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Infrastructure"
        }
      });

      const countPopulationClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Population"
        }
      });

      const countPovertyClusters = await clustersModel.countDocuments({
        cluster: {
          $eq: "Poverty"
        }
      });

      
      console.log(`All: ${countAll}
      Agriculture: ${countAgricultureClusters}
      Conflict: ${countConflictClusters},
      Economic: ${countEconomicClusters}
      Education: ${countEducationClusters}
      Environment: ${countEnvironmentClusters}
      Food Security and Nutrition: ${countFoodSecurityAndNutritiontClusters}
      Gender: ${countGenderClusters},
      Health: ${countHealthClusters}
      Infrastructure: ${countInfrastructureClusters}
      Population: ${countPopulationClusters}
      Poverty: ${countPovertyClusters}`);
    

    } catch (err) {
      res.send('Error: ' + err);
    }

  }
  countDocumentsBasedonClusters().catch(console.dir);


  // Get all data
  clustersModel.find({}).then(function (cluster) {
    res.send(cluster);
  });
})


module.exports = {
  getClusters: getClusters,
  getCluster: getCluster,
  getClusterBasedOnIndicator: getClusterBasedOnIndicator,
  createCluster: createCluster,
  updateClusterByID: updateClusterByID,
  updateClusterByClusterName: updateClusterByClusterName,
  deleteClusterByID: deleteClusterByID,
  deleteClusterByClusterName: deleteClusterByClusterName,
  getCountDocumentsPerCluster: getCountDocumentsPerCluster
}