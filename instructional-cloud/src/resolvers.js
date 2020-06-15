const { User, Workshop } = require('./models');

const resolvers = {
    Query: {
      getUsers: async () => {
        return await User.find({}).exec()
      },
      getUser: async (_, { _id }) => {
        return await User.findById(_id).exec()
      },
      getWorkshops: async () => {
        return await Workshop.find({}).exec()
      },
      getWorkshop: async (_, { _id }) =>  {
        const workshop = await Workshop.findById(_id).exec()
        console.log(workshop)
        const user = await User.findById(workshop.user_id).exec()
        console.log(user)
        workshop.user = user
        return workshop
      }
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