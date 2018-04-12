class CodeCategory < ApplicationRecord

  # Relations
  has_many :codes

  # Validations
  validates :title, presence: true
end
