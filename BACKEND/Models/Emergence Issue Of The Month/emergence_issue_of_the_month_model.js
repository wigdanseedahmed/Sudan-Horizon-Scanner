// Import Mongoose
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create Event Detail Schema and Model
const EmergenceIssueOfTheMonthSchema = new Schema({
    emergingIssue: {
        type: String
    },
    repetition: {
        type: Number
    },
    totalDataCount: { 
        type: Number
    },
    positiveSentimentAnalysisDataCount: {
        type: Number
    },
    neutralSentimentAnalysisDataCount: {
        type: Number
    },
    negativeSentimentAnalysisDataCount: {
        type: Number
    },
    time: {
        type: String
    },
    sdgTargeted: {
        type: String
    },
    summary: {
        type: String
    },
    sources: {
        type: [String]
    }
});


const EmergenceIssueOfTheMonthModel = mongoose.model('emergence_issue_of_the_month', EmergenceIssueOfTheMonthSchema, 'emergence_issue_of_the_month');
module.exports = {
    EmergenceIssueOfTheMonthSchema: EmergenceIssueOfTheMonthSchema,
    EmergenceIssueOfTheMonthModel: EmergenceIssueOfTheMonthModel
};