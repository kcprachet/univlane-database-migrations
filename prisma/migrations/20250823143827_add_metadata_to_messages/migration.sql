/*
  Warnings:

  - You are about to drop the column `streamChannelId` on the `conversations` table. All the data in the column will be lost.
  - You are about to drop the column `streamChannelId` on the `leads` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "public"."conversations" DROP COLUMN "streamChannelId";

-- AlterTable
ALTER TABLE "public"."leads" DROP COLUMN "streamChannelId";

-- AlterTable
ALTER TABLE "public"."messages" ADD COLUMN     "metadata" JSONB;
