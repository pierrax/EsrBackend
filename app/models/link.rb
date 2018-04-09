class Link < ApplicationRecord

  # Relations
  belongs_to :institution
  belongs_to :category, class_name: 'CategoryLink', foreign_key: 'category_link_id'

  # Validation
  validates :content, presence: true
end
