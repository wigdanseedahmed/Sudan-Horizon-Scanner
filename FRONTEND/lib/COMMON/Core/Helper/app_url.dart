class AppUrl {
  static const String liveBaseURL = "https://remote-ur/api/v1";
  static const String localBaseURL = "http://192.168.1.129:4000";

  // "http://192.168.8.126:4000"; for Canar
  // "http://172.20.10.2:4000"; for iphone 13
  // "http://172.20.10.5:4000"; iphone 6
  // "http://192.168.1.106:4000"; Work
  // "http://192.168.1.101:4000"; Baba
  // 192.168.5.26 JENAN

  static const String baseURL = localBaseURL; //liveBaseURL;
  static const String digitalAvatarBaseURL = baseURL + "/digital-avatar";
  static const String interventionsBaseURL = baseURL + "/interventions";
  static const String emergenceIssueOfTheMonthBaseURL =
      baseURL + '/emergence-issue-of-the-month';
  static const String politicalMappingBaseURL = baseURL + "/political-mapping";

  ///--------------- DIGITAL AVATAR ---------------///
  static const String cluster = digitalAvatarBaseURL + "/cluster";
  static const String clusterBasedOnIndicator = digitalAvatarBaseURL +
      "/cluster/clusterandindicator/"; //:cluster&:indicators

  ///--------------- INTERVENTIONS ---------------///
  static const String projects = interventionsBaseURL + "/project";
  static const String projectTotalDonatedAmount =
      interventionsBaseURL + '/project/totalDonatedAmount/'; //:projectName
  static const String states = interventionsBaseURL + "/state";
  static const String localities = interventionsBaseURL + "/locality";

  ///--------------- EMERGENCE ISSUE OF THE MONTH ---------------///

  /// EMERGENCE ISSUE OF THE MONTH
// Get a list of localities from the DB
  static const String getEmergingIssues =
      emergenceIssueOfTheMonthBaseURL + "/emergenceIssueOfTheMonth";

//   router.get('/emergenceIssueOfTheMonth', getEmergingIssues);
  static const String getEmergingIssueByName = emergenceIssueOfTheMonthBaseURL +
      "//emergenceIssueOfTheMonth/findbyname/";

//   router.get('/emergenceIssueOfTheMonth/findbyname/:emergingIssue', getEmergingIssueByName);

// Add new emergenceIssueOfTheMonth to the DB
  static const String createEmergingIssue =
      emergenceIssueOfTheMonthBaseURL + "/emergenceIssueOfTheMonth";

//   router.post('/emergenceIssueOfTheMonth', createEmergingIssue);

// Update a emergenceIssueOfTheMonth in the DB
  static const String updateEmergingIssueByID =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthid/";

//   router.put('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthid/:id', updateEmergingIssueByID);
  static const String updateEmergingIssueByEmergingIssueName =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameen/";

//   router.put('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameen/:emergingIssue', updateEmergingIssueByEmergingIssueName);

// Delete a emergenceIssueOfTheMonth from the DB
  static const String deleteEmergingIssueByID =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthid/";

//   router.delete('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthid/:id', deleteEmergingIssueByID);
  static const String deleteEmergingIssueByEmergingIssueName =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameen/";

//   router.delete('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameen/:politicalMappingEventName', deleteEmergingIssueByEmergingIssueName);

  /// EMERGENCE ISSUE OF THE MONTH DATA
// Get a list of localities from the DB
  static const String getEmergingIssuesData =
      emergenceIssueOfTheMonthBaseURL + "/emergenceIssueOfTheMonthData";

// router.get('/emergenceIssueOfTheMonthData', getEmergingIssuesData);
  static const String getEmergingIssueDataByName =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonthData/findbyname/";

// router.get('/emergenceIssueOfTheMonthData/findbyname/:emergingIssue', getEmergingIssueDataByName);

// Add new emergenceIssueOfTheMonth to the DB
  static const String createEmergingIssueData =
      emergenceIssueOfTheMonthBaseURL + "/emergenceIssueOfTheMonthData";

// router.post('/emergenceIssueOfTheMonthData', createEmergingIssueData);

// Update a emergenceIssueOfTheMonth in the DB
  static const String updateEmergingIssueDataByID =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthid/";

// router.put('/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthid/:id', updateEmergingIssueDataByID);

  static const String updateEmergingIssueDataByEmergingIssueName =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthnameen/";

// router.put('/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthnameen/:emergingIssue', updateEmergingIssueDataByEmergingIssueName);

// Delete a emergenceIssueOfTheMonth from the DB
  static const String deleteEmergingIssueDataByID =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthid/";

//router.delete('/emergenceIssueOfTheMonthData/emergenceIssueOfTheMonthid/:id', deleteEmergingIssueDataByID);

  static const String deleteEmergingIssueDataByEmergingIssueName =
      emergenceIssueOfTheMonthBaseURL +
          "/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameenData/";

// router.delete('/emergenceIssueOfTheMonth/emergenceIssueOfTheMonthnameenData/:politicalMappingEventName', deleteEmergingIssueDataByEmergingIssueName);

  ///--------------- POLITICAL MAPPING ---------------///
  /// POLITICAL MAPPING ~ COALITION
  static const String getPoliticalMappingCoalitions =
      politicalMappingBaseURL + "/politicalcoalition";

  /// POLITICAL MAPPING ~ EVENT
  static const String getPoliticalMappingEvents =
      politicalMappingBaseURL + "/politicalevent";

  /// POLITICAL MAPPING ~ PARTY OR INTEREST GROUPS
  static const String getPoliticalMappingPartyGroups =
      politicalMappingBaseURL + "/politicalpartygroupactor";

  /// POLITICAL MAPPING ~ PEOPLE
  static const String getPoliticalMappingIndividuals =
      politicalMappingBaseURL + "/politicalindividualactor";

  /// POLITICAL MAPPING ~ STATE
  static const String getPoliticalMappingStates =
      politicalMappingBaseURL + "/politicalstate";

  /// USERS
  static const String login = baseURL + "/session";
  static const String register = baseURL + "/registration";
  static const String forgotPassword = baseURL + "/forgot-password";
}
