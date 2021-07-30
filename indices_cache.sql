--quantos índices estão no cache
SELECT Sum(idx_blks_read)                                             AS idx_read,
       Sum(idx_blks_hit)                                              AS idx_hit,
       ( Sum(idx_blks_hit) - Sum(idx_blks_read) ) / Sum(idx_blks_hit) AS ratio
FROM   pg_statio_user_indexes; 