// https://medium.com/@williamyang93/graphql-apollo-mongodb-mongoose-part-i-a727bb22f1f6
const mongoose = require('mongoose');
const Schema = mongoose.Schema;

const userSchema = Schema({
  _id: Schema.Types.ObjectId,
  name: String,
  email: String,
  workshops: [{
    type:  Schema.Types.ObjectId,
    ref: 'workshop'
  }]
});

const workshopSchema = Schema ({
  _id: Schema.Types.ObjectId,
  title: String,
  cover_image_url: String,
  user: {
    type:  Schema.Types.ObjectId,
    ref: 'user'
  }
})

const User = mongoose.model('user', userSchema, 'users')
const Workshop =  mongoose.model('workshop', workshopSchema, 'workshops')

// console.log(mongoose.modelNames())

module.exports = {
  User, Workshop
}