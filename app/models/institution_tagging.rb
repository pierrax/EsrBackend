class InstitutionTagging < ApplicationRecord
  # self.table_name = 'institutions_institution_tags'

  enum status: { archived: 0, active: 1 }
  # Relations
  belongs_to :institution
  belongs_to :institution_tag

  # Validation
end
