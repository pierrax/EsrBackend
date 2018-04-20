class InstitutionTagging < ApplicationRecord
  # self.table_name = 'institutions_institution_tags'

  # Relations
  belongs_to :institution
  belongs_to :institution_tag

  # Validation
end
