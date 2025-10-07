-- CreateTable
CREATE TABLE "public"."agent_question_sets" (
    "id" TEXT NOT NULL,
    "agent_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "description" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,
    "created_by" TEXT,

    CONSTRAINT "agent_question_sets_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."question_templates" (
    "id" TEXT NOT NULL,
    "org_id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "question_text" TEXT NOT NULL,
    "question_type" TEXT NOT NULL,
    "options" JSONB,
    "validation_rules" JSONB,
    "is_required" BOOLEAN NOT NULL DEFAULT false,
    "display_order" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "question_templates_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."question_set_items" (
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
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "question_set_items_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."lead_flow_sessions" (
    "id" TEXT NOT NULL,
    "conversation_id" TEXT NOT NULL,
    "agent_id" TEXT NOT NULL,
    "question_set_id" TEXT,
    "current_question_id" TEXT,
    "collected_data" JSONB NOT NULL DEFAULT '{}',
    "session_metadata" JSONB NOT NULL DEFAULT '{}',
    "language_code" TEXT NOT NULL DEFAULT 'en',
    "is_completed" BOOLEAN NOT NULL DEFAULT false,
    "started_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "completed_at" TIMESTAMP(3),
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "lead_flow_sessions_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."lead_analytics" (
    "id" TEXT NOT NULL,
    "org_id" TEXT NOT NULL,
    "agent_id" TEXT,
    "lead_id" TEXT,
    "event_type" TEXT NOT NULL,
    "event_data" JSONB,
    "session_duration" INTEGER,
    "question_response_time" INTEGER,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "lead_analytics_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."lead_file_uploads" (
    "id" TEXT NOT NULL,
    "lead_id" TEXT NOT NULL,
    "question_id" TEXT,
    "file_name" TEXT NOT NULL,
    "file_path" TEXT NOT NULL,
    "file_size" INTEGER NOT NULL,
    "mime_type" TEXT NOT NULL,
    "uploaded_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "lead_file_uploads_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."lead_appointments" (
    "id" TEXT NOT NULL,
    "lead_id" TEXT NOT NULL,
    "agent_id" TEXT NOT NULL,
    "appointment_date" TIMESTAMP(3) NOT NULL,
    "duration_minutes" INTEGER NOT NULL DEFAULT 30,
    "meeting_link" TEXT,
    "status" TEXT NOT NULL DEFAULT 'scheduled',
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "lead_appointments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "public"."lead_consents" (
    "id" TEXT NOT NULL,
    "lead_id" TEXT NOT NULL,
    "consent_type" TEXT NOT NULL,
    "granted" BOOLEAN NOT NULL,
    "consent_text" TEXT NOT NULL,
    "ip_address" TEXT,
    "user_agent" TEXT,
    "granted_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "lead_consents_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "agent_question_sets_agent_id_name_key" ON "public"."agent_question_sets"("agent_id", "name");

-- AddForeignKey
ALTER TABLE "public"."agent_question_sets" ADD CONSTRAINT "agent_question_sets_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "public"."agents"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."agent_question_sets" ADD CONSTRAINT "agent_question_sets_created_by_fkey" FOREIGN KEY ("created_by") REFERENCES "public"."users"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."question_templates" ADD CONSTRAINT "question_templates_org_id_fkey" FOREIGN KEY ("org_id") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."question_set_items" ADD CONSTRAINT "question_set_items_question_set_id_fkey" FOREIGN KEY ("question_set_id") REFERENCES "public"."agent_question_sets"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."question_set_items" ADD CONSTRAINT "question_set_items_question_template_id_fkey" FOREIGN KEY ("question_template_id") REFERENCES "public"."question_templates"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_flow_sessions" ADD CONSTRAINT "lead_flow_sessions_conversation_id_fkey" FOREIGN KEY ("conversation_id") REFERENCES "public"."conversations"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_flow_sessions" ADD CONSTRAINT "lead_flow_sessions_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "public"."agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_flow_sessions" ADD CONSTRAINT "lead_flow_sessions_question_set_id_fkey" FOREIGN KEY ("question_set_id") REFERENCES "public"."agent_question_sets"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_analytics" ADD CONSTRAINT "lead_analytics_org_id_fkey" FOREIGN KEY ("org_id") REFERENCES "public"."Organization"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_analytics" ADD CONSTRAINT "lead_analytics_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "public"."agents"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_analytics" ADD CONSTRAINT "lead_analytics_lead_id_fkey" FOREIGN KEY ("lead_id") REFERENCES "public"."leads"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_file_uploads" ADD CONSTRAINT "lead_file_uploads_lead_id_fkey" FOREIGN KEY ("lead_id") REFERENCES "public"."leads"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_appointments" ADD CONSTRAINT "lead_appointments_lead_id_fkey" FOREIGN KEY ("lead_id") REFERENCES "public"."leads"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_appointments" ADD CONSTRAINT "lead_appointments_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "public"."agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."lead_consents" ADD CONSTRAINT "lead_consents_lead_id_fkey" FOREIGN KEY ("lead_id") REFERENCES "public"."leads"("id") ON DELETE CASCADE ON UPDATE CASCADE;
