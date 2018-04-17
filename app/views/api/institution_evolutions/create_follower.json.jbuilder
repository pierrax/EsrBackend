json.array!(@institution.followers) do |institution|
  json.id institution.id
end
