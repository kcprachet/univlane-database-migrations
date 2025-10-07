-- CreateTable
CREATE TABLE "public"."default_question_templates" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "question_text" TEXT NOT NULL,
    "question_type" TEXT NOT NULL,
    "options" JSONB,
    "validation_rules" JSONB,
    "is_required" BOOLEAN NOT NULL DEFAULT false,
    "display_order" INTEGER,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "description" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "default_question_templates_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "default_question_templates_name_key" ON "public"."default_question_templates"("name");
