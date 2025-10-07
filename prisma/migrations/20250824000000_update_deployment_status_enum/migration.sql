-- Update existing deployment status values to match new enum format
UPDATE "agents" 
SET "deploymentStatus" = 'NOT_DEPLOYED' 
WHERE "deploymentStatus" = 'not_deployed';

UPDATE "agents" 
SET "deploymentStatus" = 'DEPLOYED' 
WHERE "deploymentStatus" = 'deployed';

UPDATE "agents" 
SET "deploymentStatus" = 'FAILED' 
WHERE "deploymentStatus" = 'failed';
