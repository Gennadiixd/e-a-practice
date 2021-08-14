/*
  Warnings:

  - You are about to drop the column `userPostInteractionId` on the `User` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "subscriptionId" INTEGER NOT NULL
);
INSERT INTO "new_User" ("email", "id", "password", "subscriptionId") SELECT "email", "id", "password", "subscriptionId" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
