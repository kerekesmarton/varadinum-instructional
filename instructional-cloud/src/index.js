const { ApolloServer, gql, makeExecutableSchema } = require('apollo-server');
const { mergeTypeDefs, mergeResolvers } = require('@graphql-toolkit/schema-merging');
const { AccountsModule } = require('@accounts/graphql-api');

const typeDefs = require('./schema');
const { creteAccountsServer } = require('./utils');
const { resolvers } = require('./resolvers');

const accountsServer = creteAccountsServer()

// We generate the accounts-js GraphQL module
const accountsGraphQL = AccountsModule.forRoot({ accountsServer });

// A new schema is created combining our schema and the accounts-js schema
const schema = makeExecutableSchema({
  typeDefs: mergeTypeDefs([typeDefs, accountsGraphQL.typeDefs]),
  resolvers: mergeResolvers([accountsGraphQL.resolvers, resolvers]),
  schemaDirectives: {
    ...accountsGraphQL.schemaDirectives,
  },
});

const server = new ApolloServer({
    schema,
    context: accountsGraphQL.context,
    engine: {
      apiKey: "service:varadinum-instructional:dpSB72RWv9JpoKNoND1naQ",
    }
});

server.listen().then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
