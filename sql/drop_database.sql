SELECT pg_terminate_backend(pg_stat_activity.pid)
FROM pg_stat_activity
WHERE datname = 'project'
  AND pid <> pg_backend_pid();

DROP DATABASE IF EXISTS project;