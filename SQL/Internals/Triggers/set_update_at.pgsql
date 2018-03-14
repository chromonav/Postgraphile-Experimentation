create trigger peep_updated_at before update
  on sellezely.peep
  for each row
  execute procedure sellezely.set_updated_at();