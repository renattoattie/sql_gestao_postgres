SELECT   pid,
         Age(Clock_timestamp(), query_start),
         usename,
         query
FROM     pg_stat_activity
WHERE    query != '<IDLE>'
AND      query NOT ilike '%pg_stat_activity%'
ORDER BY query_start DESC;

-- kill running query
SELECT pg_cancel_backend(procpid);

-- kill idle query
SELECT pg_terminate_backend(procpid);