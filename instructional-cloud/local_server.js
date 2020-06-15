// https://auth0.com/blog/develop-modern-apps-with-react-graphql-apollo-and-add-authentication/
const { ApolloServer, AuthenticationError } = require('apollo-server-express');
const express  = require('express');
const { User, Workshop } = require('./src/models');

require('./src/store');

const typeDefs = require('./src/typedefs');

const resolvers = require('./src/resolvers');

const server = new ApolloServer({
  typeDefs,
  resolvers,
});

const app = express();
server.applyMiddleware({ app });

app.listen({ port: 4000 }, () =>
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
);