-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_User" (
    "id" TEXT NOT NULL PRIMARY KEY,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "userPostInteractionId" INTEGER,
    "subscribtionId" INTEGER,
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("subscribtionId") REFERENCES "Subscribtion" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("email", "id", "password", "subscribtionId", "userPostInteractionId") SELECT "email", "id", "password", "subscribtionId", "userPostInteractionId" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");
CREATE UNIQUE INDEX "User_subscribtionId_unique" ON "User"("subscribtionId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
