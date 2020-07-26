// https://auth0.com/blog/develop-modern-apps-with-react-graphql-apollo-and-add-authentication/
const { ApolloServer, AuthenticationError } = require('apollo-server-express');
const express  = require('express');
const { User, Workshop } = require('./src/models');
const jwt = require('jsonwebtoken');
const jwksClient = require('jwks-rsa');

require('./src/store');

const typeDefs = require('./src/typedefs');

const resolvers = require('./src/resolvers');

const client = jwksClient({
  jwksUri: `https://marton.eu.auth0.com/.well-known/jwks.json`
});

function getKey(header, callback){
  client.getSigningKey(header.kid, function(err, key) {
    var signingKey = key.publicKey || key.rsaPublicKey;
    callback(null, signingKey);
  });
}

const options = {
  audience: '98Pb8nTbsIKlevr1hAXbVitp2jCnPErz',
  issuer: `https://marton.eu.auth0.com/`,
  algorithms: ['RS256']
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  context: ({ req }) => {
    console.log("received event:")
    console.log(req);
    // simple auth check on every request
    const token = req.headers.authorization;
    const user = new Promise((resolve, reject) => {
      jwt.verify(token, getKey, options, (err, decoded) => {
        if(err) {
          console.log(`Error: ${err}`);
          return reject(err);
        }
        resolve(decoded.email);
      });
    });
    console.log(`found user ${user.email}`);
    return {
      user
    };
  },
});

const app = express();
server.applyMiddleware({ app });

app.listen({ port: 4000 }, () =>
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
);