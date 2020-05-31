module.exports = {
  Query: {
    me: (_, __, { dataSources }) => dataSources.userAPI.findOrCreateUser(),
    sensitiveInformation: () => 'Sensitive info',
  },
  
  Mutation: {
    login: async (_, { email }, { dataSources }) => {
      const user = await dataSources.userAPI.findOrCreateUser({ email });
      if (user) return Buffer.from(email).toString('base64');
    }

  }
    
};
