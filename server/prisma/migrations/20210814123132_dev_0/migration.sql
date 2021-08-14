-- CreateEnum
CREATE TYPE "Theme" AS ENUM ('DARK', 'LIGHT');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "theme" "Theme" NOT NULL DEFAULT E'LIGHT',
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "email" VARCHAR(254) NOT NULL,
    "password" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Post" (
    "id" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "textContent" TEXT,
    "title" TEXT NOT NULL,
    "coverImgUrl" TEXT,
    "url" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "isSponsored" BOOLEAN,
    "writer" TEXT,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UsersPosts" (
    "userId" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "isHidden" BOOLEAN NOT NULL DEFAULT false,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "isPostponed" BOOLEAN NOT NULL DEFAULT false
);

-- CreateTable
CREATE TABLE "Board" (
    "ownerId" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "id" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "isPublic" BOOLEAN NOT NULL DEFAULT false,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Author" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "hostUrl" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserFeed" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "ownerId" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuthorBundle" (
    "id" TEXT NOT NULL,
    "title" TEXT NOT NULL,
    "description" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_AuthorToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_BoardToPost" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_AuthorToUserFeed" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "_AuthorToAuthorBundle" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "UsersPosts.userId_postId_unique" ON "UsersPosts"("userId", "postId");

-- CreateIndex
CREATE UNIQUE INDEX "_AuthorToUser_AB_unique" ON "_AuthorToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_AuthorToUser_B_index" ON "_AuthorToUser"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_BoardToPost_AB_unique" ON "_BoardToPost"("A", "B");

-- CreateIndex
CREATE INDEX "_BoardToPost_B_index" ON "_BoardToPost"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AuthorToUserFeed_AB_unique" ON "_AuthorToUserFeed"("A", "B");

-- CreateIndex
CREATE INDEX "_AuthorToUserFeed_B_index" ON "_AuthorToUserFeed"("B");

-- CreateIndex
CREATE UNIQUE INDEX "_AuthorToAuthorBundle_AB_unique" ON "_AuthorToAuthorBundle"("A", "B");

-- CreateIndex
CREATE INDEX "_AuthorToAuthorBundle_B_index" ON "_AuthorToAuthorBundle"("B");

-- AddForeignKey
ALTER TABLE "Post" ADD FOREIGN KEY ("authorId") REFERENCES "Author"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsersPosts" ADD FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UsersPosts" ADD FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Board" ADD FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "UserFeed" ADD FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorToUser" ADD FOREIGN KEY ("A") REFERENCES "Author"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorToUser" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BoardToPost" ADD FOREIGN KEY ("A") REFERENCES "Board"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_BoardToPost" ADD FOREIGN KEY ("B") REFERENCES "Post"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorToUserFeed" ADD FOREIGN KEY ("A") REFERENCES "Author"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorToUserFeed" ADD FOREIGN KEY ("B") REFERENCES "UserFeed"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorToAuthorBundle" ADD FOREIGN KEY ("A") REFERENCES "Author"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_AuthorToAuthorBundle" ADD FOREIGN KEY ("B") REFERENCES "AuthorBundle"("id") ON DELETE CASCADE ON UPDATE CASCADE;
