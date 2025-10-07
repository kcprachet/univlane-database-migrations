-- RemoveSkillsAndLanguagesFromHumanAgents
-- This migration removes the skills and languages columns from the human_agents table

-- Remove the skills column
ALTER TABLE "human_agents" DROP COLUMN IF EXISTS "skills";

-- Remove the languages column  
ALTER TABLE "human_agents" DROP COLUMN IF EXISTS "languages";
