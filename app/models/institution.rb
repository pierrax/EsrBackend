class Institution < ApplicationRecord

  # Relations
  has_many :names, class_name: 'InstitutionName', foreign_key: 'institution_id', dependent: :destroy
  accepts_nested_attributes_for :names
  has_many :addresses, as: :addressable, dependent: :destroy
  has_many :links, dependent: :destroy
  has_many :codes, dependent: :destroy
  has_many :institution_taggings, foreign_key: :institution_id, class_name: 'InstitutionTagging', dependent: :destroy
  has_many :tags, through: :institution_taggings, source: :institution_tag

  has_many :predecessor_evolutions, foreign_key: :follower_id, class_name: 'InstitutionEvolution', dependent: :destroy
  has_many :predecessors, through: :predecessor_evolutions, source: :predecessor

  has_many :follower_evolutions, foreign_key: :predecessor_id, class_name: 'InstitutionEvolution', dependent: :destroy
  has_many :followers, through: :follower_evolutions, source: :follower

  has_many :mother_connections, foreign_key: :daughter_id, class_name: 'InstitutionConnection', dependent: :destroy
  has_many :mothers, through: :mother_connections, source: :mother

  has_many :daughter_connections, foreign_key: :mother_id, class_name: 'InstitutionConnection', dependent: :destroy
  has_many :daughters, through: :daughter_connections, source: :daughter

  # Validations
  validates :date_start, presence: true

  # Scopes
  scope :with_name_or_initials, -> (q) { joins(:names).where("lower(institution_names.text) LIKE ? OR lower(institution_names.initials) LIKE ? OR lower(institutions.synonym) LIKE ?", "%#{q.downcase}%", "%#{q.downcase}%", "%#{q.downcase}%") }

  def name
    names.active.first.try(:text)
  end

  def address
    addresses.active.first
  end

  def code_uai
    codes.from_category(CodeCategory::UAI_ID).first.try(:content)
  end

  def code_siret
    codes.from_category(CodeCategory::SIRET_ID).first.try(:content)
  end

  def old_names
    names.archived.map { |n| [n.text, n.initials].compact.join(', ') }
  end
end
