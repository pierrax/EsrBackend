class InstitutionConnection < ApplicationRecord

  # Relations
  belongs_to :mother, class_name: 'Institution', foreign_key: 'mother_id'
  belongs_to :daughter, class_name: 'Institution', foreign_key: 'daughter_id'
  belongs_to :category, class_name: 'InstitutionConnectionCategory', foreign_key: 'institution_connection_category_id'

  # Validations
  validates :mother_id, presence: true
  validates :daughter_id, presence: true
  validates :institution_connection_category_id, presence: true
end
