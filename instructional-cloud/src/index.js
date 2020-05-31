const { ApolloServer } = require('apollo-server');
const typeDefs = require('./schema');
const { createStore } = require('./utils');
const { resolvers } = require('./resolvers');

const UserAPI = require('./datasources/user');

const store = createStore();

const server = new ApolloServer({
    typeDefs,
    resolvers,
    dataSources: () => ({
      userAPI: new UserAPI({ store })
    }),
    engine: {
      apiKey: "service:varadinum-instructional:dpSB72RWv9JpoKNoND1naQ",
    }
});

server.listen().then(({ url }) => {
  console.log(`🚀 Server ready at ${url}`);
});
