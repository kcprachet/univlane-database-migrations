-- AddOrganizationBranding
-- This migration safely adds the branding column to the Organization table
DO $$
BEGIN
    -- Check if the Organization table exists
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_schema = 'public' AND table_name = 'Organization') THEN
        -- Check if the branding column already exists
        IF NOT EXISTS (SELECT FROM information_schema.columns WHERE table_schema = 'public' AND table_name = 'Organization' AND column_name = 'branding') THEN
            ALTER TABLE "Organization" ADD COLUMN "branding" JSONB;
        END IF;
    END IF;
END $$;
