-- AlterTable
ALTER TABLE "public"."human_agents" ADD COLUMN     "bufferTime" INTEGER NOT NULL DEFAULT 15,
ADD COLUMN     "maxAdvanceBooking" INTEGER NOT NULL DEFAULT 30,
ADD COLUMN     "minAdvanceBooking" INTEGER NOT NULL DEFAULT 2,
ADD COLUMN     "slotDuration" INTEGER NOT NULL DEFAULT 30,
ADD COLUMN     "workingDays" INTEGER[] DEFAULT ARRAY[1, 2, 3, 4, 5]::INTEGER[];
