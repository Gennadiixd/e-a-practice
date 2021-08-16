export const Mutation = {
  createPost: (parent, args, ctx) => {
    return ctx.prisma.post.create({
      data: {
        title: args.title,
        authorId: args.authorId,
        textContent: args.textContent,
        url: args.url,
      },
    })
  },

  updatePost: (parent, args, ctx) => {
    return ctx.prisma.post.update({
      where: {
        id: args.id,
      },
      data: {
        title: args.title,
        textContent: args.textContent,
        url: args.url,
      },
    })
  },

  deletePost: (parent, args, ctx) => {
    return ctx.prisma.post.delete({
      where: {
        id: args.id,
      },
    })
  },
};
