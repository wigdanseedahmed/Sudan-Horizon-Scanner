const { getUsers,
  getUser,
  checkUsernameExists,
  checkEmailExists,
  logIn,
  register,
  updateUserInformationByID,
  updateUserInformationByUsername,
  updateUserInformationByEmail,
  updateUserPasswordByUsername,
  updateUserPasswordByEmail,
  deleteUserByID,
  deleteUserByUsername,
  deleteUserByEmail } = require("../Controller/user_api_controller");

const config = require("../config");
let middleware = require("../middleware");

const jwt = require("jsonwebtoken");

const express = require("express");
const router = express.Router();

// Get a list of users from the DB
router.get('/users', getUsers);

router.route("/:username").get(middleware.checkToken, getUser);

// Check to see if user exists
router.route("/users/checkusername/:username").get(checkUsernameExists);

router.route("/users/checkemail/:email").get(checkEmailExists);

// Login User
router.route("/login").post(logIn);

// Register User
router.route("/register").post(register);

// Update user information in the DB
router.put("/users/id/:id", updateUserInformationByID);

router.put("/users/username/:username", updateUserInformationByUsername);

router.put("/users/email/:email", updateUserInformationByEmail);

// Update user password in the DB
router.put("/users/password/username/:username", updateUserPasswordByUsername);

router.put("/users/password/email/:email", updateUserPasswordByEmail);

// Delete a user from the DB
router.delete("/users/id/:id", deleteUserByID);

router.delete("/users/username/:username", deleteUserByUsername);

router.delete("/users/email/:email", deleteUserByEmail);

module.exports = router;