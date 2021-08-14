import { PrismaClient } from '@prisma/client';
import { QueryResolvers } from '../generated/resolver-types';

export const Query: QueryResolvers<{ prisma: PrismaClient }> = {
  user(parent, args, ctx) {
    return ctx.prisma.user.findUnique({
      where: { id: args.userId },
      include: {
        boards: {
          include: {
            posts: true,
          },
        },
        feeds: {
          include: {
            authors:true
          }
        },
        authorSubscriptionList: true,
      },
    });
  },

  board(parent, args, ctx) {
    return ctx.prisma.board.findUnique({
      where: { id: args.boardId },
      include: { posts: true },
    });
  },

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
        select: {
          posts: { take: 20, skip: 1 },
        },
      })
      .posts();
  },
};
