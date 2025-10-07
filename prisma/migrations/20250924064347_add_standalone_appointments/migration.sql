-- CreateTable
CREATE TABLE "public"."appointments" (
    "id" TEXT NOT NULL,
    "agent_id" TEXT,
    "human_agent_id" TEXT NOT NULL,
    "lead_id" TEXT,
    "end_user_name" TEXT NOT NULL,
    "end_user_email" TEXT NOT NULL,
    "end_user_phone" TEXT,
    "appointment_date" TIMESTAMP(3) NOT NULL,
    "duration_minutes" INTEGER NOT NULL DEFAULT 30,
    "meeting_type" TEXT NOT NULL DEFAULT 'video',
    "meeting_link" TEXT,
    "status" TEXT NOT NULL DEFAULT 'scheduled',
    "notes" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "appointments_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "appointments_human_agent_id_idx" ON "public"."appointments"("human_agent_id");

-- CreateIndex
CREATE INDEX "appointments_appointment_date_idx" ON "public"."appointments"("appointment_date");

-- CreateIndex
CREATE INDEX "appointments_status_idx" ON "public"."appointments"("status");

-- AddForeignKey
ALTER TABLE "public"."appointments" ADD CONSTRAINT "appointments_agent_id_fkey" FOREIGN KEY ("agent_id") REFERENCES "public"."agents"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."appointments" ADD CONSTRAINT "appointments_human_agent_id_fkey" FOREIGN KEY ("human_agent_id") REFERENCES "public"."human_agents"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "public"."appointments" ADD CONSTRAINT "appointments_lead_id_fkey" FOREIGN KEY ("lead_id") REFERENCES "public"."leads"("id") ON DELETE SET NULL ON UPDATE CASCADE;
