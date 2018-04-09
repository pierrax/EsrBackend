class Code < ApplicationRecord

  # Relations
  belongs_to :institution
  belongs_to :category, class_name: 'CategoryCode', foreign_key: 'category_code_id'

  # Validation
  validates :content, presence: true
end
