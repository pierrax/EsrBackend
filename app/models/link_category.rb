class LinkCategory < ApplicationRecord

  # Relations
  has_many :links

  # Validations
  validates :title, presence: true
end
