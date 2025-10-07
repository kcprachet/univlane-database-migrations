/*
  Warnings:

  - You are about to drop the `human_agents` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `human_chat_sessions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `human_messages` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "human_agents" DROP CONSTRAINT "human_agents_organizationId_fkey";

-- DropForeignKey
ALTER TABLE "human_agents" DROP CONSTRAINT "human_agents_userId_fkey";

-- DropForeignKey
ALTER TABLE "human_agents" DROP CONSTRAINT "human_agents_workspaceId_fkey";

-- DropForeignKey
ALTER TABLE "human_chat_sessions" DROP CONSTRAINT "human_chat_sessions_conversationId_fkey";

-- DropForeignKey
ALTER TABLE "human_chat_sessions" DROP CONSTRAINT "human_chat_sessions_humanAgentId_fkey";

-- DropForeignKey
ALTER TABLE "human_chat_sessions" DROP CONSTRAINT "human_chat_sessions_organizationId_fkey";

-- DropForeignKey
ALTER TABLE "human_chat_sessions" DROP CONSTRAINT "human_chat_sessions_userId_fkey";

-- DropForeignKey
ALTER TABLE "human_chat_sessions" DROP CONSTRAINT "human_chat_sessions_workspaceId_fkey";

-- DropForeignKey
ALTER TABLE "human_messages" DROP CONSTRAINT "human_messages_humanChatSessionId_fkey";

-- DropForeignKey
ALTER TABLE "users" DROP CONSTRAINT "users_organizationId_fkey";

-- DropTable
DROP TABLE "human_agents";

-- DropTable
DROP TABLE "human_chat_sessions";

-- DropTable
DROP TABLE "human_messages";

-- AddForeignKey
ALTER TABLE "users" ADD CONSTRAINT "users_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;
