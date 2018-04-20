class InstitutionTagCategory < ApplicationRecord

  # Relations
  has_many :tags, class_name: 'InstitutionTag', foreign_key: 'institution_tag_category_id'

  # Validations
  validates :title, presence: true
end
