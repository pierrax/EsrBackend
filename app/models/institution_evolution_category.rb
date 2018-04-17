class InstitutionEvolutionCategory < ApplicationRecord

  # Relations
  has_many :evolutions, class_name: 'InstitutionEvolution', foreign_key: 'institution_evolution_category_id'

  # Validations
  validates :title, presence: true
end
