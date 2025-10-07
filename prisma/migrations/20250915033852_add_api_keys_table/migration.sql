-- CreateTable
CREATE TABLE "public"."api_keys" (
    "id" TEXT NOT NULL,
    "key" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "expiresAt" TIMESTAMP(3) NOT NULL,
    "permissions" TEXT[] DEFAULT ARRAY[]::TEXT[],
    "lastUsedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "api_keys_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "api_keys_key_key" ON "public"."api_keys"("key");

-- CreateIndex
CREATE INDEX "api_keys_organizationId_idx" ON "public"."api_keys"("organizationId");

-- CreateIndex
CREATE INDEX "api_keys_userId_idx" ON "public"."api_keys"("userId");

-- CreateIndex
CREATE INDEX "api_keys_type_idx" ON "public"."api_keys"("type");

-- CreateIndex
CREATE INDEX "api_keys_isActive_idx" ON "public"."api_keys"("isActive");

-- CreateIndex
CREATE INDEX "api_keys_expiresAt_idx" ON "public"."api_keys"("expiresAt");

-- AddForeignKey
ALTER TABLE "public"."api_keys" ADD CONSTRAINT "api_keys_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."api_keys" ADD CONSTRAINT "api_keys_userId_fkey" FOREIGN KEY ("userId") REFERENCES "public"."users"("id") ON DELETE CASCADE ON UPDATE CASCADE;
