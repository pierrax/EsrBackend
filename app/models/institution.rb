class Institution < ApplicationRecord

  # Relations
  has_many :names, class_name: 'InstitutionName', foreign_key: 'institution_id'

  # Validation
  validates :date_start, presence: true

  def name
    names.active.first
  end
end
