const { ApolloServer, gql, makeExecutableSchema } = require('apollo-server');
const { mergeTypeDefs, mergeResolvers } = require('@graphql-toolkit/schema-merging');
const { AccountsModule } = require('@accounts/graphql-api');

const mongoose = require('mongoose');
const { Mongo } = require('@accounts/mongo');
const { AccountsServer } = require('@accounts/server');
const { AccountsPassword } = require('@accounts/password');


const typeDefs = require('./schema');
//const { creteAccountsServer } = require('./utils');
const { resolvers } = require('./resolvers');

//const accountsServer = creteAccountsServer()

mongoose.connect('mongodb://localhost:27017/instructional-mongoose', {
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
    tokenSecret: 'my-super-random-secret',
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
    engine: {
      apiKey: "service:varadinum-instructional:dpSB72RWv9JpoKNoND1naQ",
    }
});

server.listen().then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
