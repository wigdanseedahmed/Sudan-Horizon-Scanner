const express = require('express');
const bodyParser = require("body-parser");
const mongoose = require('mongoose');

const port = process.env.port || 4000;


// Set up Express app
const sudanHorizonScannerApp = express();

// Connect to mongodb
mongoose.connect(
    'mongodb://localhost/sudan_horizon_scanner', {
        useNewUrlParser: true,
        useUnifiedTopology: true
    }
);
mongoose.Promise = global.Promise;

const connection = mongoose.connection;
connection.once("open", () => {
    console.log("MongoDb connected");
});

// Middleware to allow users to input output image
sudanHorizonScannerApp.use(express.static('public'))

// Body Parse Middleware 
sudanHorizonScannerApp.use(bodyParser.json());

// Initialize routes
data = {
    msg: "Welcome on DevStack Blog App development YouTube video series",
    info: "This is a root endpoint",
    Working: "Documentations of other endpoints will be release soon :)",
    request: "Hey if you did'nt subscribed my YouTube channle please subscribe it",
};

sudanHorizonScannerApp.route("/").get((req, res) => res.json(data));

// CORS
const cors = require('cors');
sudanHorizonScannerApp.use(cors({
    origin: '*',
    credentials: true,

}));

// Middleware
sudanHorizonScannerApp.use("/uploads", express.static("uploads"));
sudanHorizonScannerApp.use(express.json());

// Initialize routes
// DIGITAL AVATAR
// sudanHorizonScannerApp.use('/digital-avatar', require('./Routes/Digital Avatar/clusters'))

// INTERVENTIONS
sudanHorizonScannerApp.use('/interventions', require('./Routes/Interventions/projects'))
sudanHorizonScannerApp.use('/interventions', require('./Routes/Interventions/localities'))
sudanHorizonScannerApp.use('/interventions', require('./Routes/Interventions/states'))

// EMERGENCE ISSUE OF THE MONTH
sudanHorizonScannerApp.use('/emergence-issue-of-the-month', require('./Routes/Emergence Issue Of The Month/emergence_issue_of_the_month'))
sudanHorizonScannerApp.use('/emergence-issue-of-the-month', require('./Routes/Emergence Issue Of The Month/emergence_issue_of_the_month_data'))


// POLITICAL MAPPING
sudanHorizonScannerApp.use('/political-mapping', require('./Routes/Political Mapping/political_mapping_coalition'))
sudanHorizonScannerApp.use('/political-mapping', require('./Routes/Political Mapping/political_mapping_event'))
sudanHorizonScannerApp.use('/political-mapping', require('./Routes/Political Mapping/political_mapping_party_group'))
sudanHorizonScannerApp.use('/political-mapping', require('./Routes/Political Mapping/political_mapping_individual'))
sudanHorizonScannerApp.use('/political-mapping', require('./Routes/Political Mapping/political_mapping_state'))

// USERS
sudanHorizonScannerApp.use("/user", require("./Routes/user"))
//sudanHorizonScannerApp.use("/api", require("./routes/profile"))

// Error handling Middleware
sudanHorizonScannerApp.use(function (err, req, res, next) {
    //console.log(err);
    res.status(422).send({
        error: err.message
    });
});

// Listen for requests
sudanHorizonScannerApp.listen(port, function () {
    console.log('now listening for requests');
});