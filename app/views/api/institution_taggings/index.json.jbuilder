json.array!(@taggings) do |tagging|
  json.id tagging.id
  json.institution_id tagging.institution_id
  json.institution_tag_id tagging.institution_tag_id
  json.date_start tagging.date_start
  json.date_end tagging.date_end
  json.status tagging.status

  json.tag tagging.institution_tag, partial: 'api/institution_tags/tag', as: :tag
end
