CREATE OR REPLACE FUNCTION sellezely.set_updated_at()
 RETURNS trigger
 LANGUAGE plpgsql
AS $function$
begin
  new.updated_at := current_timestamp;
  return new;
end;
$function$