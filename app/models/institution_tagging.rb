class InstitutionTagging < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  # Relations
  belongs_to :institution
  belongs_to :institution_tag

  # Scopes
  scope :ordered_by_category, -> { joins(institution_tag: :category).order('position asc') }
end
