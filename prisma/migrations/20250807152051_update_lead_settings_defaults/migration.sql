-- AlterTable
ALTER TABLE "agent_lead_settings" ALTER COLUMN "triggerKeywords" SET DEFAULT ARRAY['apply', 'admission', 'enquire', 'register', 'contact']::TEXT[],
ALTER COLUMN "introText" SET DEFAULT 'Please fill out this short form so our university team can assist you further.';
