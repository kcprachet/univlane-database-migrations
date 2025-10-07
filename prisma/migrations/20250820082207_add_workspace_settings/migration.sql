-- CreateTable
CREATE TABLE "public"."workspace_settings" (
    "id" TEXT NOT NULL,
    "workspaceId" TEXT NOT NULL,
    "name" TEXT,
    "description" TEXT,
    "timezone" TEXT DEFAULT 'UTC',
    "language" TEXT DEFAULT 'en',
    "settings" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "workspace_settings_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "workspace_settings_workspaceId_key" ON "public"."workspace_settings"("workspaceId");

-- AddForeignKey
ALTER TABLE "public"."workspace_settings" ADD CONSTRAINT "workspace_settings_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "public"."Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;
