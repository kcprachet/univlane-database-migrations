-- CreateTable
CREATE TABLE "public"."organization_question_sets" (
    "id" TEXT NOT NULL,
    "org_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "created_by" TEXT,

    CONSTRAINT "organization_question_sets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."organization_question_set_items" (
    "id" TEXT NOT NULL,
    "question_set_id" TEXT NOT NULL,
    "question_template_id" TEXT,
    "custom_question_text" TEXT,
    "question_type" TEXT NOT NULL,
    "options" JSONB,
    "validation_rules" JSONB,
    "is_required" BOOLEAN NOT NULL DEFAULT false,
    "display_order" INTEGER NOT NULL,
    "conditional_logic" JSONB,
    "field_mapping" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "organization_question_set_items_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "organization_question_sets_org_id_name_key" ON "public"."organization_question_sets"("org_id", "name");

-- AddForeignKey
ALTER TABLE "public"."organization_question_sets" ADD CONSTRAINT "organization_question_sets_org_id_fkey" FOREIGN KEY ("org_id") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."organization_question_sets" ADD CONSTRAINT "organization_question_sets_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."organization_question_set_items" ADD CONSTRAINT "organization_question_set_items_question_set_id_fkey" FOREIGN KEY ("question_set_id") REFERENCES "public"."organization_question_sets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."organization_question_set_items" ADD CONSTRAINT "organization_question_set_items_question_template_id_fkey" FOREIGN KEY ("question_template_id") REFERENCES "public"."question_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;
