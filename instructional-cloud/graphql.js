const { ApolloServer, gql, makeExecutableSchema } = require('apollo-server-lambda');
// const { ApolloServer, gql, makeExecutableSchema } = require('apollo-server');
const { mergeTypeDefs, mergeResolvers } = require('@graphql-toolkit/schema-merging');
const { AccountsModule } = require('@accounts/graphql-api');

const mongoose = require('mongoose');
const { Mongo } = require('@accounts/mongo');
const { AccountsServer } = require('@accounts/server');
const { AccountsPassword } = require('@accounts/password');

const typeDefs = require('./schema');
const { resolvers } = require('./resolvers');

mongoose.connect('mongodb+srv://mkerekes_mongo:'+process.env.mongo_db_pwd+'@cluster0-p1v4h.mongodb.net/test', {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

const accountsMongo = new Mongo(mongoose.connection);

const accountsPassword = new AccountsPassword({
  // You can customise the behavior of the password service by providing some options
});

const accountsServer = new AccountsServer(
  {
    // We link the mongo adapter we created in the previous step to the server
    db: accountsMongo,
    // Replace this value with a strong random secret
    tokenSecret: process.env.account_secret,
  },
  {
    // We pass a list of services to the server, in this example we just use the password service
    password: accountsPassword,
  }
);

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
  // context: ({ event, context }) => ({
  //   headers: event.headers,
  //   functionName: context.functionName,
  //   event,
  //   context,
  // }),
  introspection: true,
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