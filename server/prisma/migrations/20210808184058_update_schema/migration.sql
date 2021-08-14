-- DropIndex
DROP INDEX "User_subscriptionId_unique";

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userPostInteractionId" INTEGER NOT NULL,
    "subscriptionId" INTEGER NOT NULL
);
INSERT INTO "new_User" ("email", "id", "password", "subscriptionId", "userPostInteractionId") SELECT "email", "id", "password", "subscriptionId", "userPostInteractionId" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");
CREATE TABLE "new_Subscription" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" TEXT,
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Subscription" ("id") SELECT "id" FROM "Subscription";
DROP TABLE "Subscription";
ALTER TABLE "new_Subscription" RENAME TO "Subscription";
CREATE UNIQUE INDEX "Subscription_userId_unique" ON "Subscription"("userId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
