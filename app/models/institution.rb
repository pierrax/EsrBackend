class Institution < ApplicationRecord

  # Relations
  has_many :names, class_name: 'InstitutionName', foreign_key: 'institution_id'
  accepts_nested_attributes_for :names
  has_many :addresses, as: :addressable
  has_many :links
  has_many :codes
  # has_many :categories, class_name: 'InstitutionCategory', foreign_key: 'institution_id'
  has_many :institution_taggings, foreign_key: :institution_id, class_name: 'InstitutionTagging'
  has_many :tags, through: :institution_taggings, source: :institution_tag

  has_many :predecessor_evolutions, foreign_key: :follower_id, class_name: 'InstitutionEvolution'
  has_many :predecessors, through: :predecessor_evolutions, source: :predecessor

  has_many :follower_evolutions, foreign_key: :predecessor_id, class_name: 'InstitutionEvolution'
  has_many :followers, through: :follower_evolutions, source: :follower

  has_many :mother_connections, foreign_key: :daughter_id, class_name: 'InstitutionConnection'
  has_many :mothers, through: :mother_connections, source: :mother

  has_many :daughter_connections, foreign_key: :mother_id, class_name: 'InstitutionConnection'
  has_many :daughters, through: :daughter_connections, source: :daughter

  # Validation
  validates :date_start, presence: true

  # Scopes
  scope :with_name_or_initials, -> (q) { joins(:names).where("lower(institution_names.text) LIKE ? OR lower(institution_names.initials) LIKE ?", "%#{q.downcase}%", "%#{q.downcase}%") }

  def name
    names.active.first.try(:text)
  end
end
