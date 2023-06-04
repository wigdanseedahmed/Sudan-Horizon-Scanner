const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create cluster Schema
const ClusterSigma = new Schema({
    cluster: {
        type: String,
        required: [true]
    },
    subCluster: {
        type: String,
        unique: true
    },
    dataSet: {
        type: String
    },
    indicators: {
        type: String
    },
    geographicalCoverage:{
        type:String
    },
    time:{
        type:String
    },
    startDate:{
        type:String
    },
    endDate:{
        type:String
    },
    duration: {
        type: Number
    }
});


const clustersModel = mongoose.model('cluster_data', ClusterSigma, 'cluster_data');
module.exports = {
    clustersModel: clustersModel,
    ClusterSigma: ClusterSigma
};