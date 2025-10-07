-- AlterTable
ALTER TABLE "Organization" ADD COLUMN     "onboardingCompleted" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "users" ADD COLUMN     "onboardingCompleted" BOOLEAN NOT NULL DEFAULT false;
