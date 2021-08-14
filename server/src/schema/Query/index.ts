// import { UserResolvers } from './user';
// import { BoardResolvers } from './board';
// import { PostResolvers } from './post';
import { QueryResolverWithPrisma } from '../types';

export const Query: QueryResolverWithPrisma = {
  user: (parent, args, ctx) => ctx.prisma.user.findUnique({
    where: { id: args.userId },
  }),
  // ...BoardResolvers,
  // ...PostResolvers,
};
