const mongoose = require('mongoose');
const Schema = mongoose.Schema;

var loginUserSchema = new Schema({
    sn: {
        type: Number,
        unique: true
    },
    username: {
        type: String,
        required: true,
        unique: true,
    },
    password: {
        type: String,
        required: true,
    },
    email: {
        type: String,
        required: true,
    },
});

var registerUserSchema = new Schema({
    sn: {
        type: Number,
        unique: true
    },
    email: {
        type: String,
        unique: true
    },
    firstName: {
        type: String
    },
    lastName: {
        type: String
    },
    companyKey: {
        type: String
    },
    username: {
        type: String,
        unique: true
    },
    password: {
        type: String
    },
    confirmedPassword: {
        type: String
    },
});


// This two schemas will save on the 'users' collection.
var User = mongoose.model('User', loginUserSchema, 'users');
var registerUser = mongoose.model('Registered', registerUserSchema, 'users');

module.exports = {
    User: User,
    registerUser: registerUser
};