import { QueryResolverWithPrisma } from '../../types';

interface IUserResolvers {
    user: QueryResolverWithPrisma['user']
}

export const UserResolvers: IUserResolvers = {
  user: (parent, args, ctx) => ctx.prisma.user.findUnique({
    where: { id: args.userId },
  }),
};
