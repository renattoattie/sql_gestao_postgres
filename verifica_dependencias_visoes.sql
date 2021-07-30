WITH recursive view_tree(parent_schema, parent_obj, child_schema, child_obj, ind, ord)
AS
  (
           SELECT   vtu_parent.view_schema,
                    vtu_parent.view_name,
                    vtu_parent.table_schema,
                    vtu_parent.table_name,
                    '',
                    array[row_number() over (ORDER BY view_schema, view_name)]
           FROM     information_schema.view_table_usage vtu_parent
           WHERE    vtu_parent.view_schema = 'sisdia'
           AND      vtu_parent.view_name = 'vw_df_grade_05km_ano_hist'
           UNION ALL
           SELECT   vtu_child.view_schema,
                    vtu_child.view_name,
                    vtu_child.table_schema,
                    vtu_child.table_name,
                    vtu_parent.ind
                             || '  ',
                    vtu_parent.ord
                             || (row_number() over (ORDER BY view_schema, view_name))
           FROM     view_tree vtu_parent,
                    information_schema.view_table_usage vtu_child
           WHERE    vtu_child.view_schema = vtu_parent.child_schema
           AND      vtu_child.view_name = vtu_parent.child_obj )
  SELECT   tree.ind
                    || tree.parent_schema
                    || '.'
                    || tree.parent_obj
                    || ' depende de '
                    || tree.child_schema
                    || '.'
                    || tree.child_obj txt,
           tree.ord
  FROM     view_tree tree
  ORDER BY ord;