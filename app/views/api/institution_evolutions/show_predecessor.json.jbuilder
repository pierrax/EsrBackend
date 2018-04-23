json.evolutions(@evolutions) do |evolution|
  json.predecessor evolution.predecessor, partial: 'api/institution_evolutions/institution', as: :institution
  json.evolution evolution, partial: 'api/institution_evolutions/evolution', as: :evolution
end

