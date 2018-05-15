class CodeCategory < ApplicationRecord

  # Relations
  has_many :codes

  # Validations
  validates :title, presence: true, uniqueness: true

  UAI_ID = 2
end
