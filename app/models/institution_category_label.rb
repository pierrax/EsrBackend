class InstitutionCategoryLabel < ApplicationRecord

  # Relations
  has_one :category, class_name: 'InstitutionCategory', foreign_key: 'institution_category_label_id'

  # Validation
end
