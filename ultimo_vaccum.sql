SELECT relname,
       n_dead_tup,
       last_vacuum,
       last_autovacuum
FROM   pg_catalog.pg_stat_all_tables
WHERE  n_dead_tup > 0
       AND relname = 'alerta_grilagem'
ORDER  BY n_dead_tup DESC; 