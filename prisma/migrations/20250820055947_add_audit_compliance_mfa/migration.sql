-- AlterTable
ALTER TABLE "public"."Organization" ADD COLUMN     "accessHours" JSONB,
ADD COLUMN     "dataResidency" TEXT,
ADD COLUMN     "domainAliases" TEXT[] DEFAULT ARRAY[]::TEXT[],
ADD COLUMN     "mfaRequired" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "ssoConnectionId" TEXT,
ADD COLUMN     "subdomainPatterns" TEXT[] DEFAULT ARRAY[]::TEXT[];

-- AlterTable
ALTER TABLE "public"."agents" ADD COLUMN     "supportedLanguages" TEXT[] DEFAULT ARRAY['en']::TEXT[],
ADD COLUMN     "welcomeMessage" TEXT;

-- AlterTable
ALTER TABLE "public"."conversations" ADD COLUMN     "detectedLanguage" TEXT;

-- AlterTable
ALTER TABLE "public"."document_chunks" ADD COLUMN     "language" TEXT NOT NULL DEFAULT 'en';

-- AlterTable
ALTER TABLE "public"."messages" ADD COLUMN     "language" TEXT NOT NULL DEFAULT 'en';

-- AlterTable
ALTER TABLE "public"."users" ADD COLUMN     "lastLoginAt" TIMESTAMP(3),
ADD COLUMN     "loginCount" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "mfaEnabled" BOOLEAN NOT NULL DEFAULT false;

-- CreateTable
CREATE TABLE "public"."audit_logs" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "action" TEXT NOT NULL,
    "resource" TEXT NOT NULL,
    "metadata" JSONB,
    "timestamp" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "ipAddress" TEXT,
    "userAgent" TEXT,

    CONSTRAINT "audit_logs_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "audit_logs_userId_idx" ON "public"."audit_logs"("userId");

-- CreateIndex
CREATE INDEX "audit_logs_timestamp_idx" ON "public"."audit_logs"("timestamp");

-- CreateIndex
CREATE INDEX "audit_logs_action_idx" ON "public"."audit_logs"("action");

-- CreateIndex
CREATE INDEX "document_chunks_language_idx" ON "public"."document_chunks"("language");

-- AddForeignKey
ALTER TABLE "public"."audit_logs" ADD CONSTRAINT "audit_logs_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
