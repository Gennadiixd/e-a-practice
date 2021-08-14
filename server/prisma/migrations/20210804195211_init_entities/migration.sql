/*
  Warnings:

  - You are about to drop the column `hiddenPosts` on the `UserPostInteraction` table. All the data in the column will be lost.
  - You are about to drop the column `posponedPosts` on the `UserPostInteraction` table. All the data in the column will be lost.
  - You are about to drop the column `readDonePosts` on the `UserPostInteraction` table. All the data in the column will be lost.
  - Added the required column `subscribtionId` to the `User` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "Post" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "boardId" INTEGER NOT NULL,
    FOREIGN KEY ("boardId") REFERENCES "Board" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "HiddenPost" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "postId" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "ReadDonePosts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "postId" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "PosponedPosts" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "postId" INTEGER NOT NULL,
    "userId" TEXT NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Feed" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "Source" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "feedId" INTEGER NOT NULL,
    FOREIGN KEY ("feedId") REFERENCES "Feed" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Subscribtion" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- CreateTable
CREATE TABLE "Board" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_UserPostInteraction" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_UserPostInteraction" ("createdAt", "id", "updatedAt") SELECT "createdAt", "id", "updatedAt" FROM "UserPostInteraction";
DROP TABLE "UserPostInteraction";
ALTER TABLE "new_UserPostInteraction" RENAME TO "UserPostInteraction";
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL DEFAULT 'USER',
    "lastLogin" DATETIME,
    "resetPasswordToken" TEXT NOT NULL,
    "dateResetPasswordRequest" DATETIME,
    "validateEmailToken" TEXT NOT NULL,
    "isEmailValidated" BOOLEAN NOT NULL,
    "name" TEXT NOT NULL,
    "userPostInteractionId" INTEGER,
    "subscribtionId" INTEGER NOT NULL,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("subscribtionId") REFERENCES "Subscribtion" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_User" ("createdAt", "dateResetPasswordRequest", "email", "id", "isEmailValidated", "lastLogin", "name", "password", "resetPasswordToken", "role", "updatedAt", "userPostInteractionId", "validateEmailToken") SELECT "createdAt", "dateResetPasswordRequest", "email", "id", "isEmailValidated", "lastLogin", "name", "password", "resetPasswordToken", "role", "updatedAt", "userPostInteractionId", "validateEmailToken" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");
CREATE UNIQUE INDEX "User_subscribtionId_unique" ON "User"("subscribtionId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
