/*
  Warnings:

  - You are about to drop the column `email` on the `human_agents` table. All the data in the column will be lost.
  - You are about to drop the column `name` on the `human_agents` table. All the data in the column will be lost.
  - You are about to drop the column `orgId` on the `human_agents` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[userId]` on the table `human_agents` will be added. If there are existing duplicate values, this will fail.
  - Made the column `userId` on table `human_agents` required. This step will fail if there are existing NULL values in that column.
  - Added the required column `human_agent_id` to the `lead_appointments` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "public"."human_agents" DROP CONSTRAINT "human_agents_orgId_fkey";

-- DropForeignKey
ALTER TABLE "public"."human_agents" DROP CONSTRAINT "human_agents_userId_fkey";

-- DropForeignKey
ALTER TABLE "public"."lead_appointments" DROP CONSTRAINT "lead_appointments_agent_id_fkey";

-- DropIndex
DROP INDEX "public"."human_agents_email_key";

-- DropIndex
DROP INDEX "public"."human_agents_orgId_idx";

-- AlterTable
ALTER TABLE "public"."human_agents" DROP COLUMN "email",
DROP COLUMN "name",
DROP COLUMN "orgId",
ALTER COLUMN "userId" SET NOT NULL;

-- AlterTable
ALTER TABLE "public"."lead_appointments" ADD COLUMN     "human_agent_id" TEXT NOT NULL,
ALTER COLUMN "agent_id" DROP NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "human_agents_userId_key" ON "public"."human_agents"("userId");

-- CreateIndex
CREATE INDEX "human_agents_userId_idx" ON "public"."human_agents"("userId");

-- AddForeignKey
ALTER TABLE "public"."human_agents" ADD CONSTRAINT "human_agents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_appointments" ADD CONSTRAINT "lead_appointments_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "public"."agents"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_appointments" ADD CONSTRAINT "lead_appointments_human_agent_id_fkey" FOREIGN KEY ("human_agent_id") REFERENCES "public"."human_agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
