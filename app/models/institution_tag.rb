class InstitutionTag < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  # Relations
  has_many :institution_taggings, foreign_key: :institution_tag_id, class_name: 'InstitutionTagging'
  has_many :institutions, through: :institution_taggings, source: :institution

  belongs_to :category, class_name: 'InstitutionTagCategory', foreign_key: 'institution_tag_category_id'

  # Validation
  validates :short_label, presence: true
  validates :long_label, presence: true

  # Scopes
  scope :ordered_by_category, -> { order('institution_tag_category_id asc') }
end
