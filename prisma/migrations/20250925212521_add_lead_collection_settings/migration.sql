-- AlterTable
ALTER TABLE "public"."agents" ADD COLUMN     "lead_collection_display_mode" TEXT DEFAULT 'all_at_once',
ADD COLUMN     "lead_collection_keywords" TEXT[] DEFAULT ARRAY[]::TEXT[],
ADD COLUMN     "lead_collection_question_set_id" TEXT,
ADD COLUMN     "lead_collection_trigger" TEXT DEFAULT 'beginning';

-- AddForeignKey
ALTER TABLE "public"."agents" ADD CONSTRAINT "agents_lead_collection_question_set_id_fkey" FOREIGN KEY ("lead_collection_question_set_id") REFERENCES "public"."agent_question_sets"("id") ON DELETE SET NULL ON UPDATE CASCADE;
