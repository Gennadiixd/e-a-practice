import { QueryResolverWithPrisma } from '../../types';

interface IPostResolvers {
    post: QueryResolverWithPrisma['post']
    posts: QueryResolverWithPrisma['posts']
}

export const PostResolvers: IPostResolvers = {
  post(parent, args, ctx) {
    return ctx.prisma.post.findUnique({
      where: { id: args.postId },
      include: { author: true },
    });
  },

  posts(parent, args, ctx) {
    return ctx.prisma.board
      .findUnique({
        where: {
          id: args.boardId,
        },
      })
      .posts();
  },
};
