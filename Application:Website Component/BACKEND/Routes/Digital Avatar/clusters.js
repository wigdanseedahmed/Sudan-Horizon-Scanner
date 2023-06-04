const  { 
    getClusters,
    getCluster,
    getClusterBasedOnIndicator,
    createCluster,
    updateClusterByID,
    updateClusterByClusterName,
    deleteClusterByID,
    deleteClusterByClusterName,
    getCountDocumentsPerCluster
} = require('../../Controller/Digital Avatar/cluster_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of localities from the DB
router.get('/cluster', getClusters);

router.get('/cluster/:cluster', getCluster);

router.get('/cluster/clusterandindicator/:cluster&:indicators', getClusterBasedOnIndicator);

// Add new Cluster to the DB
router.post('/cluster', createCluster);

// Update a Cluster in the DB
router.put('/cluster/clusterid/:id', updateClusterByID);

router.put('/cluster/clusternameen/:ClusterNameEN', updateClusterByClusterName);

// Delete a Cluster from the DB
router.delete('/cluster/clusterid/:id', deleteClusterByID);

router.delete('/cluster/clusternameen/:clusterNameEN', deleteClusterByClusterName);

// Count cluster documents from the DB
router.get('/cluster/count', getCountDocumentsPerCluster);

module.exports = router;