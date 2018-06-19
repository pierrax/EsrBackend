class Link < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  # Relations
  belongs_to :institution
  belongs_to :category, class_name: 'LinkCategory', foreign_key: 'link_category_id'

  # Validation
  validates :content, presence: true

  # Scopes
  scope :ordered_by_category, -> { order('link_category_id asc') }
end
