class InstitutionCategory < ApplicationRecord

  # Relations
  belongs_to :institution
  belongs_to :label, class_name: 'InstitutionCategoryLabel', foreign_key: 'institution_category_label_id'

  # Validation

end
