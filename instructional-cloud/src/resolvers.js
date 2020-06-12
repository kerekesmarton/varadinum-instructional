const { User, Workshop } = require('./models');

const resolvers = {
    Query: {
      getUsers: async () => await User.find({}).exec(),
      getUser: async (_, { _id }) => await User.findById(_id).exec(),
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

  module.exports = resolvers