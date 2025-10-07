-- CreateTable
CREATE TABLE "public"."performance_metrics" (
    "id" TEXT NOT NULL,
    "requestId" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "conversationId" TEXT,
    "totalTime" INTEGER NOT NULL,
    "databaseTime" INTEGER NOT NULL,
    "ragTime" INTEGER NOT NULL,
    "intentDetectionTime" INTEGER NOT NULL,
    "languageDetectionTime" INTEGER NOT NULL,
    "cacheHits" INTEGER NOT NULL DEFAULT 0,
    "cacheMisses" INTEGER NOT NULL DEFAULT 0,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "userAgent" TEXT,
    "ipAddress" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "performance_metrics_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "performance_metrics_agentId_idx" ON "public"."performance_metrics"("agentId");

-- CreateIndex
CREATE INDEX "performance_metrics_timestamp_idx" ON "public"."performance_metrics"("timestamp");

-- CreateIndex
CREATE INDEX "performance_metrics_requestId_idx" ON "public"."performance_metrics"("requestId");

-- CreateIndex
CREATE INDEX "performance_metrics_conversationId_idx" ON "public"."performance_metrics"("conversationId");

-- CreateIndex
CREATE INDEX "performance_metrics_agentId_timestamp_idx" ON "public"."performance_metrics"("agentId", "timestamp");
