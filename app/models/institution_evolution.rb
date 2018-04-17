class InstitutionEvolution < ApplicationRecord

  # Relations
  belongs_to :predecessor, class_name: 'Institution', foreign_key: 'predecessor_id'
  belongs_to :follower, class_name: 'Institution', foreign_key: 'follower_id'
  belongs_to :category, class_name: 'InstitutionEvolutionCategory', foreign_key: 'institution_evolution_category_id'

  # Validations
  validates :predecessor_id, presence: true
  validates :follower_id, presence: true
  validates :institution_evolution_category_id, presence: true
end
