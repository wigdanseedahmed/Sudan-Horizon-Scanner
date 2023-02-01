const  { 
    getProjects,
    createProject,
    updateProjectByID,
    updateProjectByProjectName,
    deleteProjectByID,
    deleteProjectByProjectName,
    filterProjectsBasedOnTheme,
    filterProjectsBasedOnRCTheme,
    filterProjectsBasedOnEETheme,
    filterProjectsBasedOnDETheme,
    filterProjectsBasedOnIDTheme,
    filterProjectsBasedOnHDTheme,
    filterProjectsBasedOnPSTheme,
    filterProjectsBasedOnThemeandLocality,
    filterProjectsBasedOnRCThemeandLocality,
    filterProjectsBasedOnEEThemeandLocality,
    filterProjectsBasedOnDEThemeandLocality,
    filterProjectsBasedOnIDThemeandLocality,
    filterProjectsBasedOnHDThemeandLocality,
    filterProjectsBasedOnPSThemeandLocality,
    countTotalDonationAmountBasedOnProjectName,
    countTotalDonationAmount
} = require('../../Controller/Interventions/projects_api_controller')

const express = require('express');
const router = express.Router();


// Get a list of projects from the DB
router.get('/project', getProjects);

// Add new project to the DB
router.post('/project', createProject);

// Update a project in the DB
router.put('/project/id/:id', updateProjectByID);

router.put('/project/projectName/:projectName', updateProjectByProjectName);


// Delete a project from the DB
router.delete('/project/id/:id', deleteProjectByID);

router.delete('/project/projectName/:projectName', deleteProjectByProjectName);

// Filter Projects based on themes
router.get('/project/filter/theme/:theme', filterProjectsBasedOnTheme);

router.get('/project/theme/R_C', filterProjectsBasedOnRCTheme);

router.get('/project/theme/E_E', filterProjectsBasedOnEETheme);

router.get('/project/theme/D_E', filterProjectsBasedOnDETheme);

router.get('/project/theme/H_D', filterProjectsBasedOnHDTheme);

router.get('/project/theme/I_D', filterProjectsBasedOnIDTheme);

router.get('/project/theme/P_S', filterProjectsBasedOnPSTheme);

// Filter projects based on themes and Locality
router.get('/project/filter/theme&locality/:localityNameEN&:theme', filterProjectsBasedOnThemeandLocality);

router.get('/project/theme&locality/:localityNameEN&:theme', filterProjectsBasedOnRCThemeandLocality);

router.get('/project/theme&locality/:localityNameEN&:theme', filterProjectsBasedOnEEThemeandLocality);

router.get('/project/theme&locality/:localityNameEN&:theme', filterProjectsBasedOnDEThemeandLocality);

router.get('/project/theme&locality/:localityNameEN&:theme', filterProjectsBasedOnHDThemeandLocality);

router.get('/project/theme&locality/:localityNameEN&:theme', filterProjectsBasedOnIDThemeandLocality);

router.get('/project/theme&locality/:localityNameEN&:theme', filterProjectsBasedOnPSThemeandLocality);

// Count total donated amount
router.get('/project/totalDonatedAmount/:projectName', countTotalDonationAmountBasedOnProjectName);

router.get('/project/totalDonatedAmount', countTotalDonationAmount);

module.exports = router;