class InstitutionTagging < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  # Relations
  belongs_to :institution
  belongs_to :institution_tag
end
