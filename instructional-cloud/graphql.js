// https://auth0.com/blog/develop-modern-apps-with-react-graphql-apollo-and-add-authentication/
const { ApolloServer, gql, AuthenticationError } = require('apollo-server-lambda');
const express  = require('express');
const { User, Workshop } = require('./src/models');
const jwt = require('jsonwebtoken');
const jwksClient = require('jwks-rsa');

require('./src/store');

const typeDefs = gql`
  type User {
    id: String!
    name: String!
    email: String!
    workshops: [Workshop]!
  }

  type Workshop {
    id: String!
    title: String!
    cover_image_url: String!
    user: User!
  }

  type Query {
      getUsers: [User],
      getWorkshops: [Workshop]
  }
  type Mutation {
      addUser(name: String!, email: String!): User
      addWorkshop(title: String!, cover_image_url: String!): Workshop
  }
`;

const resolvers = {
  Query: {
    getUsers: async () => await User.find({}).exec(),
    getWorkshops: async () => await Workshop.find({}).exec()
  },
  Mutation: {
    addUser: async (_, args) => {
        try {
            let response = await User.create(args);
            return response;
        } catch(e) {
            return e.message;
        }
    },
    addWorkshop: async (_, args, { user }) => {
      try {
        const email = await user; // catching the reject from the user promise.
        let response = await Workshop.create(args);
        return response;
      } catch(e) {
        throw new AuthenticationError('You must be logged in to do this');
      }
    }
  }
};

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
    // simple auth check on every request
    const token = req.headers.authorization;
    const user = new Promise((resolve, reject) => {
      jwt.verify(token, getKey, options, (err, decoded) => {
        if(err) {
          return reject(err);
        }
        resolve(decoded.email);
      });
    });

    return {
      user
    };
  },
  playground: {
    endpoint: "/dev/graphql"
  }
});

exports.graphqlHandler = server.createHandler({
  cors: {
    origin: true,
    credentials: true,
  },    
});