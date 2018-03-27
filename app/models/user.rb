class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable

  # Validations
  validates :email, presence: true, uniqueness: true, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :last_name, presence: true, length: { in: 2..30 }
  validates :first_name, presence: true, length: { in: 2..30 }
end
