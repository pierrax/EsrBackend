class Code < ApplicationRecord

  # Relations
  belongs_to :institution
  belongs_to :category, class_name: 'CodeCategory', foreign_key: 'code_category_id'

  # Validation
  validates :content, presence: true
end
