-- CreateTable
CREATE TABLE "UserPostInteraction" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "readDonePosts" TEXT NOT NULL,
    "hiddenPosts" TEXT NOT NULL,
    "posponedPosts" TEXT NOT NULL
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
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
    FOREIGN KEY ("userPostInteractionId") REFERENCES "UserPostInteraction" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_User" ("createdAt", "dateResetPasswordRequest", "email", "id", "isEmailValidated", "lastLogin", "name", "password", "resetPasswordToken", "role", "updatedAt", "validateEmailToken") SELECT "createdAt", "dateResetPasswordRequest", "email", "id", "isEmailValidated", "lastLogin", "name", "password", "resetPasswordToken", "role", "updatedAt", "validateEmailToken" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User.email_unique" ON "User"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
