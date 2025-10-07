-- AddComplianceFlagsToAuditLogs
ALTER TABLE "audit_logs" ADD COLUMN "complianceFlags" JSONB;
