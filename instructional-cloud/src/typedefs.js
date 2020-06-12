const { gql } = require('apollo-server-express');

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
      getUser(_id: ID!): User,
      getWorkshops: [Workshop],
      getWorkshop(_id: ID!): Workshop
  }
  type Mutation {
      addUser(name: String!, email: String!): User
      addWorkshop(title: String!, cover_image_url: String!): Workshop
  }
`;

module.exports = typeDefs;