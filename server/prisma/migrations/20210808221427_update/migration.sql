-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_UserPostInteraction" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "postId" INTEGER,
    "isPostHidden" BOOLEAN NOT NULL,
    "isPostPostponed" BOOLEAN NOT NULL,
    "isPostRead" BOOLEAN NOT NULL,
    "userId" TEXT NOT NULL,
    FOREIGN KEY ("postId") REFERENCES "Post" ("id") ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_UserPostInteraction" ("createdAt", "id", "isPostHidden", "isPostPostponed", "isPostRead", "postId", "updatedAt", "userId") SELECT "createdAt", "id", "isPostHidden", "isPostPostponed", "isPostRead", "postId", "updatedAt", "userId" FROM "UserPostInteraction";
DROP TABLE "UserPostInteraction";
ALTER TABLE "new_UserPostInteraction" RENAME TO "UserPostInteraction";
CREATE UNIQUE INDEX "UserPostInteraction_postId_unique" ON "UserPostInteraction"("postId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
