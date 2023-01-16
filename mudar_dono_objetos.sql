DO $$
DECLARE
   objeto record;
BEGIN
   FOR objeto IN (SELECT nspname, relname, relkind
                  FROM pg_class c
                  JOIN pg_namespace n ON n.oid = c.relnamespace
                  WHERE relkind IN ('r', 'v', 'm', 'S', 'f')
                  )
   LOOP
      IF objeto.relkind = 'r' THEN
         EXECUTE 'ALTER TABLE ' || objeto.nspname || '.' || objeto.relname || ' OWNER TO new_owner';
      ELSIF objeto.relkind = 'v' THEN
         EXECUTE 'ALTER VIEW ' || objeto.nspname || '.' || objeto.relname || ' OWNER TO new_owner';
      ELSIF objeto.relkind = 'S' THEN
         EXECUTE 'ALTER SEQUENCE ' || objeto.nspname || '.' || objeto.relname || ' OWNER TO new_owner';
      ELSIF objeto.relkind = 'm' THEN
         EXECUTE 'ALTER MATERIALIZED VIEW ' || objeto.nspname || '.' || objeto.relname || ' OWNER TO new_owner';
      ELSIF objeto.relkind = 'f' THEN
         EXECUTE 'ALTER FUNCTION ' || objeto.nspname || '.' || objeto.relname || '(...) OWNER TO new_owner';
      END IF;
   END LOOP;
END $$;
