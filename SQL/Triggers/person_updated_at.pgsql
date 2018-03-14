create trigger person_updated_at before update
  on sellezely.person
  for each row
  execute procedure sellezely.set_updated_at();