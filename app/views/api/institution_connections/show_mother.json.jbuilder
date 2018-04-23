json.connections(@connections) do |connection|
  json.predecessor connection.mother, partial: 'api/institution_connections/institution', as: :institution
  json.connection connection, partial: 'api/institution_connections/connection', as: :connection
end

