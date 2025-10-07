-- AlterTable
ALTER TABLE "agents" ADD COLUMN "deployedAt" TIMESTAMP(3),
ADD COLUMN "deployedUrl" TEXT,
ADD COLUMN "deploymentError" TEXT,
ADD COLUMN "deploymentStatus" TEXT NOT NULL DEFAULT 'not_deployed',
ADD COLUMN "lastDeploymentCheck" TIMESTAMP(3);

-- CreateIndex
CREATE INDEX "agents_deploymentStatus_idx" ON "agents"("deploymentStatus"); 