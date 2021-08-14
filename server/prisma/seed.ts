import { PrismaClient } from '@prisma/client';
import * as bcrypt from 'bcryptjs';

const prisma = new PrismaClient();
async function main() {
  // Create a user
  const user = await prisma.user.create({
    data: {
      email: 'admin@test.test',
      firstName: 'Artyom',
      lastName: 'Admin',
      password: await bcrypt.hash('admin', 10),
    },
  });

  // Create an author
  const author = await prisma.author.create({
    data: {
      description: 'First ever author',
      hostUrl: 'https://hello-world.com',
      title: 'BOSS',
    },
  });

  const post1 = {
    data: {
      title: 'I am Joker',
      authorId: author.id,
      url: 'joker.com',
    },
  };
  const post2 = {
    data: {
      title: 'I am batman',
      authorId: author.id,
      url: 'batman.com',
    },
  };

  // Create two posts
  const [postOne, postTwo] = await Promise.all([
    prisma.post.create(post1),
    prisma.post.create(post2),
  ]);

  // Create a board
  await prisma.board.create({
    data: {
      title: 'My fav board',
      description: 'I like it',
      owner: {
        connect: { id: user.id },
      },
      posts: {
        connect: [{ id: postOne.id }, { id: postTwo.id }],
      },
    },
    include: {
      posts: true,
    },
  });
}
main()
    .catch((e) => {
      console.error(e);
      process.exit(1);
    })
    .finally(async () => {
      await prisma.$disconnect();
    });
