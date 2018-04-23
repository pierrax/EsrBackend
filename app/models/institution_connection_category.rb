class InstitutionConnectionCategory < ApplicationRecord

  # Relations
  has_many :connections, class_name: 'InstitutionConnection', foreign_key: 'institution_connection_category_id'

  # Validations
  validates :title, presence: true
end
