const { ApolloServer, gql } = require('apollo-server-lambda');

// Construct a schema, using GraphQL schema language
const typeDefs = gql`
  type Query {
    hello: String
  }
`;

// Provide resolver functions for your schema fields
const resolvers = {
  Query: {
    hello: () => 'Hello world!',
  },
};

const server = new ApolloServer({ 
    typeDefs,
    resolvers,
    introspection: true,
    context: ({ event, context }) => ({
        headers: event.headers,
        functionName: context.functionName,
        event,
        context,
    }),
    playground: {
        endpoint: "/dev/graphql",
        tabs: [
            {
              endpoint,
              query: defaultQuery,
            },
          ],
    }
 });

exports.graphqlHandler = server.createHandler({
    cors: {
        origin: true,
        credentials: true,
      },
});