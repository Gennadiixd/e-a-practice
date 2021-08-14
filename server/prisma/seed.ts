import { PrismaClient } from '@prisma/client'
import * as bcrypt from 'bcryptjs'

const prisma = new PrismaClient()
async function main() {
  const user = await prisma.user.create({
    data: {
      email: `admin@naperg.com`,
      password: await bcrypt.hash('admin', 10),
    },
  })

  console.log({ user })
}
main()
  .catch((e) => {
    console.error(e)
    process.exit(1)
  })
  .finally(async () => {
    await prisma.$disconnect()
  })
