-- Migrate data from agent_question_sets to organization_question_sets
-- This migration handles the transition from agent-specific question sets to organization-wide question sets
-- Note: If the old tables don't exist (already dropped), this migration will be a no-op

-- Step 1: Migrate agent question sets to organization question sets (only if old table exists)
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'agent_question_sets') THEN
        INSERT INTO "public"."organization_question_sets" (
            "id",
            "org_id", 
            "name",
            "description",
            "is_active",
            "created_at",
            "updated_at",
            "created_by"
        )
        SELECT 
            aqs."id",
            a."orgId" as "org_id",
            aqs."name" || ' (from ' || a."name" || ')' as "name",
            COALESCE(aqs."description", 'Migrated from agent ' || a."name") as "description",
            aqs."is_active",
            aqs."created_at",
            aqs."updated_at",
            aqs."created_by"
        FROM "public"."agent_question_sets" aqs
        JOIN "public"."agents" a ON aqs."agent_id" = a."id"
        WHERE NOT EXISTS (
            SELECT 1 FROM "public"."organization_question_sets" oqs 
            WHERE oqs."id" = aqs."id"
        );
    END IF;
END $$;

-- Step 2: Migrate question set items to organization question set items (only if old table exists)
DO $$
BEGIN
    IF EXISTS (SELECT FROM information_schema.tables WHERE table_name = 'question_set_items') THEN
        INSERT INTO "public"."organization_question_set_items" (
            "id",
            "question_set_id",
            "question_template_id",
            "custom_question_text",
            "question_type",
            "options",
            "validation_rules",
            "is_required",
            "display_order",
            "conditional_logic",
            "field_mapping",
            "created_at",
            "updated_at"
        )
        SELECT 
            qsi."id",
            qsi."question_set_id",
            qsi."question_template_id",
            qsi."custom_question_text",
            qsi."question_type",
            qsi."options",
            qsi."validation_rules",
            qsi."is_required",
            qsi."display_order",
            qsi."conditional_logic",
            qsi."field_mapping",
            qsi."created_at",
            qsi."updated_at"
        FROM "public"."question_set_items" qsi
        WHERE NOT EXISTS (
            SELECT 1 FROM "public"."organization_question_set_items" oqsi 
            WHERE oqsi."id" = qsi."id"
        );
    END IF;
END $$;

-- Step 3: Update lead_flow_sessions to reference organization question sets
-- (This should already be handled by the foreign key update, but let's be explicit)
UPDATE "public"."lead_flow_sessions" 
SET "question_set_id" = "question_set_id"
WHERE "question_set_id" IS NOT NULL;

-- Step 4: Drop foreign key constraints that reference the old tables (if they exist)
ALTER TABLE "public"."lead_flow_sessions" DROP CONSTRAINT IF EXISTS "lead_flow_sessions_question_set_id_fkey";

-- Step 5: Drop the old tables (if they exist)
DROP TABLE IF EXISTS "public"."question_set_items" CASCADE;
DROP TABLE IF EXISTS "public"."agent_question_sets" CASCADE;

-- Step 6: Add the correct foreign key constraint for lead_flow_sessions
ALTER TABLE "public"."lead_flow_sessions" ADD CONSTRAINT "lead_flow_sessions_question_set_id_fkey" FOREIGN KEY ("question_set_id") REFERENCES "public"."organization_question_sets"("id") ON DELETE SET NULL ON UPDATE CASCADE;
