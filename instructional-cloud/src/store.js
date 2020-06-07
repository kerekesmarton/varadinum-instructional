require('dotenv').config();
const mongoose = require('mongoose');
mongoose.Promise = global.Promise;

const path = 'cluster0-p1v4h.mongodb.net/';

const url = `mongodb+srv://mkerekes_mongo:${process.env.mongo_db_pwd}@${path}`;

mongoose.connect(url, { useNewUrlParser: true, useUnifiedTopology: true, dbName: 'varadinum-instructional' });

var db = mongoose.connection;

db.on('error', console.error.bind(console, 'connection error:'));
db.once('open', () => console.log(`Connected to mongodb cluster at ${path}`));
