/*
  Warnings:

  - You are about to drop the `HiddenPost` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `PosponedPosts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ReadDonePosts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Subscribtion` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the column `subscribtionId` on the `User` table. All the data in the column will be lost.
  - Added the required column `originUrl` to the `Post` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isPostHidden` to the `UserPostInteraction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isPostPostponed` to the `UserPostInteraction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `isPostRead` to the `UserPostInteraction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `postId` to the `UserPostInteraction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `UserPostInteraction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `userId` to the `Board` table without a default value. This is not possible if the table is not empty.
  - Added the required column `subscriptionId` to the `User` table without a default value. This is not possible if the table is not empty.
  - Made the column `userPostInteractionId` on table `User` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `originUrl` to the `Feed` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "User_subscribtionId_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "HiddenPost";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "PosponedPosts";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "ReadDonePosts";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Subscribtion";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Subscription" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "_FeedToSource" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    FOREIGN KEY ("A") REFERENCES "Feed" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("B") REFERENCES "Source" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Post" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "boardId" INTEGER NOT NULL,
    "originUrl" TEXT NOT NULL,
    FOREIGN KEY ("boardId") REFERENCES "Board" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Post" ("boardId", "id") SELECT "boardId", "id" FROM "Post";
DROP TABLE "Post";
ALTER TABLE "new_Post" RENAME TO "Post";
CREATE TABLE "new_UserPostInteraction" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "postId" INTEGER NOT NULL,
    "isPostHidden" BOOLEAN NOT NULL,
    "isPostPostponed" BOOLEAN NOT NULL,
    "isPostRead" BOOLEAN NOT NULL,
    "userId" TEXT NOT NULL,
    FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_UserPostInteraction" ("createdAt", "id", "updatedAt") SELECT "createdAt", "id", "updatedAt" FROM "UserPostInteraction";
DROP TABLE "UserPostInteraction";
ALTER TABLE "new_UserPostInteraction" RENAME TO "UserPostInteraction";
CREATE TABLE "new_Board" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" TEXT NOT NULL,
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Board" ("id") SELECT "id" FROM "Board";
DROP TABLE "Board";
ALTER TABLE "new_Board" RENAME TO "Board";
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    "subscriptionId" INTEGER NOT NULL,
    FOREIGN KEY ("subscriptionId") REFERENCES "Subscription" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_User" ("email", "id", "password", "userPostInteractionId") SELECT "email", "id", "password", "userPostInteractionId" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");
CREATE UNIQUE INDEX "User_subscriptionId_unique" ON "User"("subscriptionId");
CREATE TABLE "new_Feed" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "originUrl" TEXT NOT NULL
);
INSERT INTO "new_Feed" ("id") SELECT "id" FROM "Feed";
DROP TABLE "Feed";
ALTER TABLE "new_Feed" RENAME TO "Feed";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_FeedToSource_AB_unique" ON "_FeedToSource"("A", "B");

-- CreateIndex
CREATE INDEX "_FeedToSource_B_index" ON "_FeedToSource"("B");
