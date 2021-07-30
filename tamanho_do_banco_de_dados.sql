SELECT datname,
       Pg_size_pretty(Pg_database_size(datname))
FROM   pg_database
ORDER  BY Pg_database_size(datname) DESC; 



--Verifique o tamanho (como no espaço em disco) de todos os bancos de dados:
SELECT d.datname                            AS Name,
       pg_catalog.Pg_get_userbyid(d.datdba) AS Owner,
       CASE
         WHEN pg_catalog.Has_database_privilege(d.datname, 'CONNECT') THEN
         pg_catalog.Pg_size_pretty(pg_catalog.Pg_database_size(d.datname))
         ELSE 'No Access'
       end                                  AS SIZE
FROM   pg_catalog.pg_database d
ORDER  BY CASE
            WHEN pg_catalog.Has_database_privilege(d.datname, 'CONNECT') THEN
            pg_catalog.Pg_database_size(d.datname)
            ELSE NULL
          end; 

--Verifique o tamanho (como no espaço em disco) de cada tabela:

SELECT nspname
       || '.'
       || relname                                    AS "relation",
       Pg_size_pretty(Pg_total_relation_size(C.oid)) AS "total_size"
FROM   pg_class C
       LEFT JOIN pg_namespace N
              ON ( N.oid = C.relnamespace )
WHERE  nspname NOT IN ( 'pg_catalog', 'information_schema' )
       AND C.relkind <> 'i'
       AND nspname !~ '^pg_toast'
ORDER  BY Pg_total_relation_size(C.oid) DESC; 