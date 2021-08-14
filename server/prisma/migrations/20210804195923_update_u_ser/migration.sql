/*
  Warnings:

  - You are about to drop the column `userId` on the `PosponedPosts` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `dateResetPasswordRequest` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `isEmailValidated` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `lastLogin` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `resetPasswordToken` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `role` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `validateEmailToken` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `ReadDonePosts` table. All the data in the column will be lost.
  - You are about to drop the column `userId` on the `HiddenPost` table. All the data in the column will be lost.
  - Made the column `userPostInteractionId` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_PosponedPosts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "postId" INTEGER NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_PosponedPosts" ("id", "postId", "userPostInteractionId") SELECT "id", "postId", "userPostInteractionId" FROM "PosponedPosts";
DROP TABLE "PosponedPosts";
ALTER TABLE "new_PosponedPosts" RENAME TO "PosponedPosts";
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    "subscribtionId" INTEGER NOT NULL,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("subscribtionId") REFERENCES "Subscribtion" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_User" ("email", "id", "password", "subscribtionId", "userPostInteractionId") SELECT "email", "id", "password", "subscribtionId", "userPostInteractionId" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");
CREATE UNIQUE INDEX "User_subscribtionId_unique" ON "User"("subscribtionId");
CREATE TABLE "new_ReadDonePosts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "postId" INTEGER NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_ReadDonePosts" ("id", "postId", "userPostInteractionId") SELECT "id", "postId", "userPostInteractionId" FROM "ReadDonePosts";
DROP TABLE "ReadDonePosts";
ALTER TABLE "new_ReadDonePosts" RENAME TO "ReadDonePosts";
CREATE TABLE "new_HiddenPost" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "postId" INTEGER NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_HiddenPost" ("id", "postId", "userPostInteractionId") SELECT "id", "postId", "userPostInteractionId" FROM "HiddenPost";
DROP TABLE "HiddenPost";
ALTER TABLE "new_HiddenPost" RENAME TO "HiddenPost";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
