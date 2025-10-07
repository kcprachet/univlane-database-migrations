/*
  Warnings:

  - You are about to drop the `lead_flow_states` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "public"."lead_flow_states" DROP CONSTRAINT "lead_flow_states_agentId_fkey";

-- DropForeignKey
ALTER TABLE "public"."lead_flow_states" DROP CONSTRAINT "lead_flow_states_conversationId_fkey";

-- DropForeignKey
ALTER TABLE "public"."lead_flow_states" DROP CONSTRAINT "lead_flow_states_orgId_fkey";

-- DropTable
DROP TABLE "public"."lead_flow_states";
