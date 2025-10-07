/*
  Warnings:

  - You are about to drop the column `isPublic` on the `agents` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Workspace" ADD COLUMN     "humanAgentSettings" JSONB;

-- AlterTable
ALTER TABLE "agents" DROP COLUMN "isPublic";

-- CreateTable
CREATE TABLE "human_agents" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "workspaceId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "isOnline" BOOLEAN NOT NULL DEFAULT false,
    "isAvailable" BOOLEAN NOT NULL DEFAULT false,
    "workingHoursStart" TEXT NOT NULL DEFAULT '09:00',
    "workingHoursEnd" TEXT NOT NULL DEFAULT '17:00',
    "timezone" TEXT NOT NULL DEFAULT 'UTC',
    "maxConcurrentChats" INTEGER NOT NULL DEFAULT 3,
    "currentChats" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "organizationId" TEXT NOT NULL,

    CONSTRAINT "human_agents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "human_chat_sessions" (
    "id" TEXT NOT NULL,
    "conversationId" TEXT NOT NULL,
    "humanAgentId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "workspaceId" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "userInfo" JSONB NOT NULL,
    "lastAiQuestion" TEXT NOT NULL,
    "lastAiResponse" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "organizationId" TEXT NOT NULL,

    CONSTRAINT "human_chat_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "human_messages" (
    "id" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "humanChatSessionId" TEXT NOT NULL,

    CONSTRAINT "human_messages_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "human_agents_userId_key" ON "human_agents"("userId");

-- CreateIndex
CREATE INDEX "human_agents_workspaceId_idx" ON "human_agents"("workspaceId");

-- CreateIndex
CREATE INDEX "human_agents_isAvailable_idx" ON "human_agents"("isAvailable");

-- CreateIndex
CREATE INDEX "human_agents_userId_idx" ON "human_agents"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "human_chat_sessions_conversationId_key" ON "human_chat_sessions"("conversationId");

-- CreateIndex
CREATE INDEX "human_chat_sessions_humanAgentId_idx" ON "human_chat_sessions"("humanAgentId");

-- CreateIndex
CREATE INDEX "human_chat_sessions_userId_idx" ON "human_chat_sessions"("userId");

-- CreateIndex
CREATE INDEX "human_chat_sessions_workspaceId_idx" ON "human_chat_sessions"("workspaceId");

-- CreateIndex
CREATE INDEX "human_chat_sessions_status_idx" ON "human_chat_sessions"("status");

-- CreateIndex
CREATE INDEX "human_messages_humanChatSessionId_idx" ON "human_messages"("humanChatSessionId");

-- AddForeignKey
ALTER TABLE "human_agents" ADD CONSTRAINT "human_agents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "human_agents" ADD CONSTRAINT "human_agents_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "human_agents" ADD CONSTRAINT "human_agents_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "human_chat_sessions" ADD CONSTRAINT "human_chat_sessions_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "human_chat_sessions" ADD CONSTRAINT "human_chat_sessions_humanAgentId_fkey" FOREIGN KEY ("humanAgentId") REFERENCES "human_agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "human_chat_sessions" ADD CONSTRAINT "human_chat_sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "human_chat_sessions" ADD CONSTRAINT "human_chat_sessions_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "human_chat_sessions" ADD CONSTRAINT "human_chat_sessions_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "human_messages" ADD CONSTRAINT "human_messages_humanChatSessionId_fkey" FOREIGN KEY ("humanChatSessionId") REFERENCES "human_chat_sessions"("id") ON DELETE CASCADE ON UPDATE CASCADE;
