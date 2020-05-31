const { gql } = require('apollo-server');

const typeDefs = gql`
  type User {
    id: ID!
    email: String!
    password: String!
    name: String!
    workshops: [Workshop]!
  }

  type Workshop {
    id: ID!
    title: String!
    preview: String!
    author: User
  }

  type Query {
    me: User
    sensitiveInformation: String
  }

  type Mutation {
    createUser(email: String!, password: String!, name: String!): User
    login(email: String, pwd: String): String
  }
`;

module.exports = typeDefs;

// queries:
//    workshops: [Workshop!]!
//    workshop(id: ID!): Workshop
//    workshopByUser(userId: ID!): [Workshop!]!
//
// mutations
//    createWorkshop(title: String!, preview: String, userId: ID!): Workshop
//
