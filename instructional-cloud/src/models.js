// https://medium.com/@williamyang93/graphql-apollo-mongodb-mongoose-part-i-a727bb22f1f6
const mongoose = require('mongoose');
const { Schema } = mongoose;

const userSchema = mongoose.Schema({
  name: String,
  email: String
});

// const workshopSchema = mongoose.Schema({
//   title: String,
//   cover_image_url: String,
//   user_id: String,
// });

const workshopSchema = new Schema ({
  title: String,
  cover_image_url: String,
  user_id: {
    type:  Schema.Types.ObjectId,
    required: true,
    ref: 'User'
  }
})

// userSchema
  
const User = mongoose.model('user', userSchema); 
const Workshop =  mongoose.model('workshop', workshopSchema);

module.exports = {
  User, Workshop
};