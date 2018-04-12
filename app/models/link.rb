class Link < ApplicationRecord

  # Relations
  belongs_to :institution
  belongs_to :category, class_name: 'LinkCategory', foreign_key: 'link_category_id'

  # Validation
  validates :content, presence: true
end
