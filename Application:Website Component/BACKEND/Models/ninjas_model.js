const mongoose = require('mongoose');
const Schema = mongoose.Schema;

// Create geolocation Schema
const GeoSchema = new Schema({
    type:{
        type: String,
        default: "Point"
    },
    coordinates:{
        type:[Number],
        index: "2dsphere"
    }
})

// Create ninja Schema and Model
const NinjaSchema = new Schema({
    name:{
        type: String,
        required: [true, 'Name field is required']
    },
    rank:{
        type: String,
        required: [true]
    },
    available:{
        type: Boolean,
        default: false
    },

    // add in geo location
    geometry: GeoSchema
})

const Ninja = mongoose.model('ninja', NinjaSchema);
//ninja is name of collection then give the objects in the collection a structure based on the schema

module.exports = Ninja;