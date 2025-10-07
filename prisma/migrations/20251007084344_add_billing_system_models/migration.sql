/*
  Warnings:

  - You are about to drop the `default_question_templates` table. If the table is not empty, all the data it contains will be lost.

*/
-- AlterTable
ALTER TABLE "public"."Organization" ADD COLUMN     "razorpayCustomerId" TEXT,
ADD COLUMN     "stripeCustomerId" TEXT;

-- DropTable
DROP TABLE "public"."default_question_templates";

-- CreateTable
CREATE TABLE "public"."subscription_plans" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "planType" TEXT NOT NULL,
    "tier" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "billingInterval" TEXT NOT NULL DEFAULT 'monthly',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "features" JSONB NOT NULL,
    "modelAccess" JSONB NOT NULL,
    "usageLimits" JSONB NOT NULL,
    "stripePriceId" TEXT,
    "razorpayPlanId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subscription_plans_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."subscriptions" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "planId" TEXT NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'active',
    "currentPeriodStart" TIMESTAMP(3) NOT NULL,
    "currentPeriodEnd" TIMESTAMP(3) NOT NULL,
    "cancelAtPeriodEnd" BOOLEAN NOT NULL DEFAULT false,
    "cancelledAt" TIMESTAMP(3),
    "trialStart" TIMESTAMP(3),
    "trialEnd" TIMESTAMP(3),
    "stripeSubscriptionId" TEXT,
    "razorpaySubscriptionId" TEXT,
    "paymentMethodId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "subscriptions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."invoices" (
    "id" TEXT NOT NULL,
    "subscriptionId" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "amount" INTEGER NOT NULL,
    "currency" TEXT NOT NULL DEFAULT 'USD',
    "status" TEXT NOT NULL DEFAULT 'draft',
    "invoiceNumber" TEXT NOT NULL,
    "dueDate" TIMESTAMP(3),
    "paidAt" TIMESTAMP(3),
    "stripeInvoiceId" TEXT,
    "razorpayInvoiceId" TEXT,
    "paymentMethodId" TEXT,
    "lineItems" JSONB NOT NULL,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "invoices_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."usage_tracking" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "subscriptionId" TEXT NOT NULL,
    "planId" TEXT NOT NULL,
    "metricType" TEXT NOT NULL,
    "currentUsage" INTEGER NOT NULL DEFAULT 0,
    "usageLimit" INTEGER NOT NULL,
    "periodStart" TIMESTAMP(3) NOT NULL,
    "periodEnd" TIMESTAMP(3) NOT NULL,
    "lastUpdated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "metadata" JSONB,

    CONSTRAINT "usage_tracking_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."payment_methods" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerPaymentMethodId" TEXT NOT NULL,
    "isDefault" BOOLEAN NOT NULL DEFAULT false,
    "last4" TEXT,
    "brand" TEXT,
    "expiryMonth" INTEGER,
    "expiryYear" INTEGER,
    "holderName" TEXT,
    "metadata" JSONB,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "payment_methods_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."billing_events" (
    "id" TEXT NOT NULL,
    "organizationId" TEXT NOT NULL,
    "eventType" TEXT NOT NULL,
    "eventData" JSONB NOT NULL,
    "provider" TEXT,
    "providerEventId" TEXT,
    "processed" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "billing_events_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "subscription_plans_planType_tier_billingInterval_key" ON "public"."subscription_plans"("planType", "tier", "billingInterval");

-- CreateIndex
CREATE INDEX "subscriptions_organizationId_idx" ON "public"."subscriptions"("organizationId");

-- CreateIndex
CREATE INDEX "subscriptions_status_idx" ON "public"."subscriptions"("status");

-- CreateIndex
CREATE INDEX "subscriptions_currentPeriodEnd_idx" ON "public"."subscriptions"("currentPeriodEnd");

-- CreateIndex
CREATE UNIQUE INDEX "invoices_invoiceNumber_key" ON "public"."invoices"("invoiceNumber");

-- CreateIndex
CREATE INDEX "invoices_subscriptionId_idx" ON "public"."invoices"("subscriptionId");

-- CreateIndex
CREATE INDEX "invoices_organizationId_idx" ON "public"."invoices"("organizationId");

-- CreateIndex
CREATE INDEX "invoices_status_idx" ON "public"."invoices"("status");

-- CreateIndex
CREATE INDEX "invoices_dueDate_idx" ON "public"."invoices"("dueDate");

-- CreateIndex
CREATE INDEX "usage_tracking_organizationId_idx" ON "public"."usage_tracking"("organizationId");

-- CreateIndex
CREATE INDEX "usage_tracking_subscriptionId_idx" ON "public"."usage_tracking"("subscriptionId");

-- CreateIndex
CREATE INDEX "usage_tracking_metricType_idx" ON "public"."usage_tracking"("metricType");

-- CreateIndex
CREATE INDEX "usage_tracking_periodStart_idx" ON "public"."usage_tracking"("periodStart");

-- CreateIndex
CREATE UNIQUE INDEX "usage_tracking_organizationId_subscriptionId_planId_metricT_key" ON "public"."usage_tracking"("organizationId", "subscriptionId", "planId", "metricType", "periodStart");

-- CreateIndex
CREATE INDEX "payment_methods_organizationId_idx" ON "public"."payment_methods"("organizationId");

-- CreateIndex
CREATE INDEX "payment_methods_provider_idx" ON "public"."payment_methods"("provider");

-- CreateIndex
CREATE INDEX "billing_events_organizationId_idx" ON "public"."billing_events"("organizationId");

-- CreateIndex
CREATE INDEX "billing_events_eventType_idx" ON "public"."billing_events"("eventType");

-- CreateIndex
CREATE INDEX "billing_events_processed_idx" ON "public"."billing_events"("processed");

-- AddForeignKey
ALTER TABLE "public"."subscriptions" ADD CONSTRAINT "subscriptions_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."subscriptions" ADD CONSTRAINT "subscriptions_planId_fkey" FOREIGN KEY ("planId") REFERENCES "public"."subscription_plans"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."invoices" ADD CONSTRAINT "invoices_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES "public"."subscriptions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."invoices" ADD CONSTRAINT "invoices_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."usage_tracking" ADD CONSTRAINT "usage_tracking_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."usage_tracking" ADD CONSTRAINT "usage_tracking_subscriptionId_fkey" FOREIGN KEY ("subscriptionId") REFERENCES "public"."subscriptions"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."usage_tracking" ADD CONSTRAINT "usage_tracking_planId_fkey" FOREIGN KEY ("planId") REFERENCES "public"."subscription_plans"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."payment_methods" ADD CONSTRAINT "payment_methods_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."billing_events" ADD CONSTRAINT "billing_events_organizationId_fkey" FOREIGN KEY ("organizationId") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;
