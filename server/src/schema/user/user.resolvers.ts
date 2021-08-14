import { Resolvers, User } from '../../generated/resolvers-types'

export const resolvers: Resolvers = {
  Query: {
    user: (_parent, args, ctx): Promise<User> => {
      const { id } = args
      return ctx.prisma.user.findUnique({
        where: { id },
        include: {
          UserPostInteraction: {
            include: {
              Post: true,
            },
          },
        },
      })
    },
  },
}
