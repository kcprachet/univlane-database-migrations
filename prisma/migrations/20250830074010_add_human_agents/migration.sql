-- AlterTable
ALTER TABLE "public"."agents" ADD COLUMN     "currentDeploymentId" TEXT,
ADD COLUMN     "deploymentConfig" JSONB,
ADD COLUMN     "deploymentVersion" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "developmentConfig" JSONB,
ALTER COLUMN "deploymentStatus" SET DEFAULT 'NOT_DEPLOYED';

-- AlterTable
ALTER TABLE "public"."conversations" ADD COLUMN     "anonymousUserId" TEXT,
ADD COLUMN     "lastSessionAt" TIMESTAMP(3),
ADD COLUMN     "sessionCount" INTEGER NOT NULL DEFAULT 1,
ADD COLUMN     "sessionId" TEXT,
ADD COLUMN     "sessionMetadata" JSONB,
ADD COLUMN     "visitCount" INTEGER NOT NULL DEFAULT 1;

-- AlterTable
ALTER TABLE "public"."messages" ADD COLUMN     "ablyMessageId" TEXT,
ADD COLUMN     "deliveryStatus" TEXT NOT NULL DEFAULT 'sent',
ADD COLUMN     "realtimeSentAt" TIMESTAMP(3),
ADD COLUMN     "sessionId" TEXT,
ADD COLUMN     "sessionSequence" INTEGER;

-- CreateTable
CREATE TABLE "public"."deployments" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "version" INTEGER NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'DRAFT',
    "configSnapshot" JSONB NOT NULL,
    "deployedAt" TIMESTAMP(3),
    "deployedUrl" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "deployments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."anonymous_users" (
    "id" TEXT NOT NULL,
    "fingerprintHash" TEXT NOT NULL,
    "deviceFingerprintId" TEXT NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "geolocation" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "lastSeenAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "anonymous_users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."device_fingerprints" (
    "id" TEXT NOT NULL,
    "canvasHash" TEXT,
    "fontList" TEXT[],
    "pluginList" TEXT[],
    "screenResolution" TEXT,
    "timezone" TEXT,
    "language" TEXT,
    "colorDepth" INTEGER,
    "pixelRatio" DOUBLE PRECISION,
    "hardwareConcurrency" INTEGER,
    "touchSupport" BOOLEAN,
    "cookieEnabled" BOOLEAN,
    "doNotTrack" BOOLEAN,
    "hash" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "device_fingerprints_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."user_sessions" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "anonymousUserId" TEXT,
    "userId" TEXT,
    "agentId" TEXT NOT NULL,
    "orgId" TEXT NOT NULL,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "lastActivityAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "metadata" JSONB,

    CONSTRAINT "user_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."embed_user_identities" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "identityType" TEXT NOT NULL,
    "identityValue" TEXT NOT NULL,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "embed_user_identities_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."typing_indicators" (
    "id" TEXT NOT NULL,
    "conversationId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "isTyping" BOOLEAN NOT NULL DEFAULT true,
    "startedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expiresAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "typing_indicators_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."handover_events" (
    "id" TEXT NOT NULL,
    "conversationId" TEXT NOT NULL,
    "fromAgentId" TEXT NOT NULL,
    "toAgentId" TEXT NOT NULL,
    "reason" TEXT NOT NULL,
    "priority" TEXT NOT NULL DEFAULT 'medium',
    "status" TEXT NOT NULL DEFAULT 'pending',
    "userMessage" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "acceptedAt" TIMESTAMP(3),
    "completedAt" TIMESTAMP(3),
    "metadata" JSONB,

    CONSTRAINT "handover_events_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."agent_status" (
    "id" TEXT NOT NULL,
    "agentId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "humanAgentId" TEXT,
    "status" TEXT NOT NULL DEFAULT 'online',
    "lastSeenAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "agent_status_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."human_agents" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "userId" TEXT,
    "orgId" TEXT NOT NULL,
    "workspaceId" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "availability" TEXT NOT NULL DEFAULT 'available',
    "maxConcurrentChats" INTEGER NOT NULL DEFAULT 3,
    "currentChats" INTEGER NOT NULL DEFAULT 0,
    "workingHoursStart" TEXT,
    "workingHoursEnd" TEXT,
    "timezone" TEXT NOT NULL DEFAULT 'UTC',
    "allowOutsideWorkingHours" BOOLEAN NOT NULL DEFAULT false,
    "skills" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "languages" TEXT[] DEFAULT ARRAY['en']::TEXT[],
    "performanceRating" DOUBLE PRECISION,
    "totalConversations" INTEGER NOT NULL DEFAULT 0,
    "totalHandovers" INTEGER NOT NULL DEFAULT 0,
    "averageResponseTime" INTEGER,
    "lastActiveAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "human_agents_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."conversation_metrics" (
    "id" TEXT NOT NULL,
    "humanAgentId" TEXT NOT NULL,
    "conversationId" TEXT NOT NULL,
    "startTime" TIMESTAMP(3) NOT NULL,
    "endTime" TIMESTAMP(3),
    "duration" INTEGER,
    "messageCount" INTEGER NOT NULL DEFAULT 0,
    "responseTime" INTEGER,
    "userSatisfaction" INTEGER,
    "handoverReason" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "conversation_metrics_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "deployments_agentId_status_idx" ON "public"."deployments"("agentId", "status");

-- CreateIndex
CREATE INDEX "deployments_status_idx" ON "public"."deployments"("status");

-- CreateIndex
CREATE UNIQUE INDEX "deployments_agentId_version_key" ON "public"."deployments"("agentId", "version");

-- CreateIndex
CREATE UNIQUE INDEX "anonymous_users_fingerprintHash_key" ON "public"."anonymous_users"("fingerprintHash");

-- CreateIndex
CREATE INDEX "anonymous_users_fingerprintHash_idx" ON "public"."anonymous_users"("fingerprintHash");

-- CreateIndex
CREATE INDEX "anonymous_users_ipAddress_idx" ON "public"."anonymous_users"("ipAddress");

-- CreateIndex
CREATE INDEX "anonymous_users_lastSeenAt_idx" ON "public"."anonymous_users"("lastSeenAt");

-- CreateIndex
CREATE UNIQUE INDEX "device_fingerprints_hash_key" ON "public"."device_fingerprints"("hash");

-- CreateIndex
CREATE INDEX "device_fingerprints_hash_idx" ON "public"."device_fingerprints"("hash");

-- CreateIndex
CREATE UNIQUE INDEX "user_sessions_sessionToken_key" ON "public"."user_sessions"("sessionToken");

-- CreateIndex
CREATE INDEX "user_sessions_sessionToken_idx" ON "public"."user_sessions"("sessionToken");

-- CreateIndex
CREATE INDEX "user_sessions_anonymousUserId_idx" ON "public"."user_sessions"("anonymousUserId");

-- CreateIndex
CREATE INDEX "user_sessions_userId_idx" ON "public"."user_sessions"("userId");

-- CreateIndex
CREATE INDEX "user_sessions_agentId_idx" ON "public"."user_sessions"("agentId");

-- CreateIndex
CREATE INDEX "user_sessions_expiresAt_idx" ON "public"."user_sessions"("expiresAt");

-- CreateIndex
CREATE INDEX "user_sessions_isActive_idx" ON "public"."user_sessions"("isActive");

-- CreateIndex
CREATE INDEX "embed_user_identities_userId_idx" ON "public"."embed_user_identities"("userId");

-- CreateIndex
CREATE INDEX "embed_user_identities_identityType_idx" ON "public"."embed_user_identities"("identityType");

-- CreateIndex
CREATE INDEX "embed_user_identities_identityValue_idx" ON "public"."embed_user_identities"("identityValue");

-- CreateIndex
CREATE INDEX "typing_indicators_conversationId_idx" ON "public"."typing_indicators"("conversationId");

-- CreateIndex
CREATE INDEX "typing_indicators_expiresAt_idx" ON "public"."typing_indicators"("expiresAt");

-- CreateIndex
CREATE INDEX "handover_events_conversationId_idx" ON "public"."handover_events"("conversationId");

-- CreateIndex
CREATE INDEX "handover_events_status_idx" ON "public"."handover_events"("status");

-- CreateIndex
CREATE INDEX "handover_events_priority_idx" ON "public"."handover_events"("priority");

-- CreateIndex
CREATE INDEX "agent_status_agentId_idx" ON "public"."agent_status"("agentId");

-- CreateIndex
CREATE INDEX "agent_status_userId_idx" ON "public"."agent_status"("userId");

-- CreateIndex
CREATE INDEX "agent_status_humanAgentId_idx" ON "public"."agent_status"("humanAgentId");

-- CreateIndex
CREATE UNIQUE INDEX "agent_status_agentId_userId_key" ON "public"."agent_status"("agentId", "userId");

-- CreateIndex
CREATE UNIQUE INDEX "human_agents_email_key" ON "public"."human_agents"("email");

-- CreateIndex
CREATE INDEX "human_agents_orgId_idx" ON "public"."human_agents"("orgId");

-- CreateIndex
CREATE INDEX "human_agents_workspaceId_idx" ON "public"."human_agents"("workspaceId");

-- CreateIndex
CREATE INDEX "human_agents_status_idx" ON "public"."human_agents"("status");

-- CreateIndex
CREATE INDEX "human_agents_availability_idx" ON "public"."human_agents"("availability");

-- CreateIndex
CREATE INDEX "conversation_metrics_humanAgentId_idx" ON "public"."conversation_metrics"("humanAgentId");

-- CreateIndex
CREATE INDEX "conversation_metrics_conversationId_idx" ON "public"."conversation_metrics"("conversationId");

-- CreateIndex
CREATE INDEX "conversation_metrics_startTime_idx" ON "public"."conversation_metrics"("startTime");

-- CreateIndex
CREATE INDEX "agents_currentDeploymentId_idx" ON "public"."agents"("currentDeploymentId");

-- CreateIndex
CREATE INDEX "conversations_anonymousUserId_idx" ON "public"."conversations"("anonymousUserId");

-- CreateIndex
CREATE INDEX "conversations_sessionId_idx" ON "public"."conversations"("sessionId");

-- CreateIndex
CREATE INDEX "messages_ablyMessageId_idx" ON "public"."messages"("ablyMessageId");

-- CreateIndex
CREATE INDEX "messages_deliveryStatus_idx" ON "public"."messages"("deliveryStatus");

-- AddForeignKey
ALTER TABLE "public"."conversations" ADD CONSTRAINT "conversations_anonymousUserId_fkey" FOREIGN KEY ("anonymousUserId") REFERENCES "public"."anonymous_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."conversations" ADD CONSTRAINT "conversations_sessionId_fkey" FOREIGN KEY ("sessionId") REFERENCES "public"."user_sessions"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."deployments" ADD CONSTRAINT "deployments_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."anonymous_users" ADD CONSTRAINT "anonymous_users_deviceFingerprintId_fkey" FOREIGN KEY ("deviceFingerprintId") REFERENCES "public"."device_fingerprints"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_sessions" ADD CONSTRAINT "user_sessions_anonymousUserId_fkey" FOREIGN KEY ("anonymousUserId") REFERENCES "public"."anonymous_users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."user_sessions" ADD CONSTRAINT "user_sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."embed_user_identities" ADD CONSTRAINT "embed_user_identities_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."typing_indicators" ADD CONSTRAINT "typing_indicators_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."typing_indicators" ADD CONSTRAINT "typing_indicators_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "public"."conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."typing_indicators" ADD CONSTRAINT "typing_indicators_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."handover_events" ADD CONSTRAINT "handover_events_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "public"."conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."handover_events" ADD CONSTRAINT "handover_events_fromAgentId_fkey" FOREIGN KEY ("fromAgentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."handover_events" ADD CONSTRAINT "handover_events_toAgentId_fkey" FOREIGN KEY ("toAgentId") REFERENCES "public"."human_agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."agent_status" ADD CONSTRAINT "agent_status_agentId_fkey" FOREIGN KEY ("agentId") REFERENCES "public"."agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."agent_status" ADD CONSTRAINT "agent_status_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."agent_status" ADD CONSTRAINT "agent_status_humanAgentId_fkey" FOREIGN KEY ("humanAgentId") REFERENCES "public"."human_agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."human_agents" ADD CONSTRAINT "human_agents_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."human_agents" ADD CONSTRAINT "human_agents_workspaceId_fkey" FOREIGN KEY ("workspaceId") REFERENCES "public"."Workspace"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."human_agents" ADD CONSTRAINT "human_agents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."conversation_metrics" ADD CONSTRAINT "conversation_metrics_humanAgentId_fkey" FOREIGN KEY ("humanAgentId") REFERENCES "public"."human_agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."conversation_metrics" ADD CONSTRAINT "conversation_metrics_conversationId_fkey" FOREIGN KEY ("conversationId") REFERENCES "public"."conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;
