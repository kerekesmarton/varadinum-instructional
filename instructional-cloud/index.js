const { prisma } = require('./generated/prisma-client')
const { GraphQLServer } = require('graphql-yoga')

const resolvers = {
  Query: {
    workshops(root, args, context) {
      return context.prisma.workshops()
    },
    workshop(root, args, context) {
      return context.prisma.workshop({ id: args.id })
    },
    workshopByUser(root, args, context) {
      return context.prisma
        .user({
          id: args.userId,
        })
        .posts()
    },
  },
  Mutation: {
    createWorkshop(root, args, context) {
      return context.prisma.createWorkshop({
        title: args.title,
        preview: args.preview,
        author: {
          connect: { id: args.userId },
        },
      })
    },
    createUser(root, args, context) {
      return context.prisma.createUser({
          email: args.email,
          name: args.name,
          password: args.password
      })
    },
  },
  User: {
    workshops(root, args, context) {
      return context.prisma
        .user({
          id: root.id,
        })
        .workshops()
    },
  },
  Workshop: {
    author(root, args, context) {
      return context.prisma
        .workshop({
          id: root.id,
        })
        .user()
    },
  },
}

const server = new GraphQLServer({
  typeDefs: './schema.graphql',
  resolvers,
  context: {
    prisma,
  },
})
server.start(() => console.log('Server is running on http://localhost:4000'))
