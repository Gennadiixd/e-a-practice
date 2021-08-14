import { QueryResolverWithPrisma } from '../../types';

interface IBoardResolvers {
  board: QueryResolverWithPrisma['board']
}

export const BoardResolvers: IBoardResolvers = {
  board: (parent, args, ctx) => ctx.prisma.board.findUnique({
    where: { id: args.boardId },
    include: { posts: true },
  }),
};
