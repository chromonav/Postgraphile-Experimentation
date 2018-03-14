To run the current sql file through psql (Postgres native client) you must add the following settings to your workspace:

```json
{ 
    "pgsql.connection": "postgres://username:password@host:port/database" 
}
```

### Creating Final Schema File:
Execute:
```bash
pg_dump -s -c --schema=schema_name postgres://username:password@url:port/dbname > target_file.pgsql
```
### To see list of Triggers:
```sql
SELECT tgname
FROM   pg_trigger
WHERE  tgrelid = 'sellezely.person'::regclass;
```

### To see tables in a schema:
```sql
\dt schema_name.*;
```

### To see description of a table:
```
\d+ schema_name.table_name
```