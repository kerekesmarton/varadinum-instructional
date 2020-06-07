// https://auth0.com/blog/develop-modern-apps-with-react-graphql-apollo-and-add-authentication/
const { ApolloServer, gql, AuthenticationError } = require('apollo-server-express');
const express  = require('express');
const { User, Workshop } = require('./models');

require('./store');

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

const server = new ApolloServer({
  typeDefs,
  resolvers,
});

const app = express();
server.applyMiddleware({ app });

app.listen({ port: 4000 }, () =>
  console.log(`🚀 Server ready at http://localhost:4000${server.graphqlPath}`)
);