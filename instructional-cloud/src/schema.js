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
    author: User
    preview: String!
  }
`;

module.exports = typeDefs;
