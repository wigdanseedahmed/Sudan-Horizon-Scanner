////////////////////////////////////////////// IMPORTS //////////////////////////////////////////////


///////////////// MODELS /////////////////
const {
    EmergenceIssueOfTheMonthModel,
    EmergenceIssueOfTheMonthSchema
  } = require('../../Models/Emergence Issue Of The Month/emergence_issue_of_the_month_model');
  
  const {
    EmergenceIssueOfTheMonthDataModel,
    EmergenceIssueOfTheMonthDataSchema
  } = require('../../Models/Emergence Issue Of The Month/emergence_issue_of_the_month_data_model');
  

  

///////////////// PACKAGES /////////////////

// const jwt = require("jsonwebtoken");

// const multer = require("multer");
// const path = require("path");

// const fs = require("fs");

////////////////////////////////////////////// FUNCTIONS //////////////////////////////////////////////

// Count the number of positive data, neutral data, and negative data
emergingIssueComponentsCalculation = function (emergingIssues) {
    //console.log(projects.length);
    for (let i = 0; i < emergingIssues.length; i++) {
  
      //console.log(projects[i].projectName);
  
      async function countComponentsPerIssue() {
  
        var totalDataCount = 0;
        var positiveSentimentAnalysisDataCount = 0;
        var neutralSentimentAnalysisDataCount = 0;
        var negativeSentimentAnalysisDataCount = 0;
  
        ///////////////////////////////////// Count the number of tasks /////////////////////////////////////
        totalDataCount = await EmergenceIssueOfTheMonthDataModel.countDocuments({
            emergenceIssue: {
                $eq: emergingIssues[i].emergingIssue
              },
        });

        
  
        if (totalDataCount == 0) {
          positiveSentimentAnalysisDataCount = 0;
          neutralSentimentAnalysisDataCount = 0;
          negativeSentimentAnalysisDataCount = 0;
        } 
        else {
          positiveSentimentAnalysisDataCount = await EmergenceIssueOfTheMonthDataModel.countDocuments({
            emergenceIssue: {
                $eq: emergingIssues[i].emergingIssue
              },
            sentimentAnalysis: {
              $eq: "Positive"
            }
          });
  
          neutralSentimentAnalysisDataCount = await EmergenceIssueOfTheMonthDataModel.countDocuments({
            emergenceIssue: {
                $eq: emergingIssues[i].emergingIssue
              },
            sentimentAnalysis: {
              $eq: "Neutral"
            }
          });
  
          negativeSentimentAnalysisDataCount = await EmergenceIssueOfTheMonthDataModel.countDocuments({
            emergenceIssue: {
              $eq: emergingIssues[i].emergingIssue
            },
            sentimentAnalysis: {
              $in: "Negative"
            }
          });
  
        }

        // console.log(`${emergingIssues[i].emergingIssue} - ${totalDataCount} = ${positiveSentimentAnalysisDataCount} + ${neutralSentimentAnalysisDataCount} + ${negativeSentimentAnalysisDataCount}`);
        
  
        await EmergenceIssueOfTheMonthModel.findOneAndUpdate({
            emergingIssue: emergingIssues[i].emergingIssue
        }, {
          $set: {
            "totalDataCount": totalDataCount,
            "positiveSentimentAnalysisDataCount": positiveSentimentAnalysisDataCount,
            "neutralSentimentAnalysisDataCount": neutralSentimentAnalysisDataCount,
            "negativeSentimentAnalysisDataCount": negativeSentimentAnalysisDataCount
          }
        }).then(

        );
  
      }
      countComponentsPerIssue().catch(console.dir);
    }
  };

  module.exports = {
    emergingIssueComponentsCalculation: emergingIssueComponentsCalculation
};