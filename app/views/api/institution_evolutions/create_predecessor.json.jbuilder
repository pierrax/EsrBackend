json.array!(@institution.predecessors) do |institution|
  json.id institution.id
end
