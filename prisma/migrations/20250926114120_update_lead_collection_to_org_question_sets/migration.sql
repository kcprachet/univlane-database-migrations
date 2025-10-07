-- DropForeignKey
ALTER TABLE "public"."agents" DROP CONSTRAINT "agents_lead_collection_question_set_id_fkey";

-- AddForeignKey
ALTER TABLE "public"."agents" ADD CONSTRAINT "agents_lead_collection_question_set_id_fkey" FOREIGN KEY ("lead_collection_question_set_id") REFERENCES "public"."organization_question_sets"("id") ON DELETE SET NULL ON UPDATE CASCADE;
