const { User, Workshop } = require('./models');

const resolvers = {
    Query: {
      getUsers: async () => {
        return await User.find({}).populate('workshops').exec()
      },
      getUser: async (_, { _id }) => {
        return await User.findById(_id).populate('workshops').exec()
      },
      getWorkshops: async () => {
        return await Workshop.find({}).populate('user').exec()
      },
      getWorkshop: async (_, { _id }) =>  {
        return await Workshop.findById(_id).populate('user').exec()
      }
      
    },
    Mutation: {
      addUser: async (_, args) => {
          try {
              let response = await User.create(args)
              return response
          } catch(e) {
              return e.message
          }
      },
      addWorkshop: async (_, args) => {
        try {
          let response = await Workshop.create(args)
          return response
        } catch(e) {
          throw e.message
        }
      }
    }
  };

  module.exports = resolvers