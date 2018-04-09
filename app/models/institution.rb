class Institution < ApplicationRecord

  # Relations
  has_many :names, class_name: 'InstitutionName', foreign_key: 'institution_id'
  accepts_nested_attributes_for :names
  has_many :addresses, as: :addressable
  has_many :links
  has_many :codes

  # Validation
  validates :date_start, presence: true

  # Scopes
  scope :with_name_or_initials, -> (q) { joins(:names).where("lower(institution_names.text) LIKE ? OR lower(institution_names.initials) LIKE ?", "%#{q.downcase}%", "%#{q.downcase}%") }

  def name
    names.active.first
  end
end
