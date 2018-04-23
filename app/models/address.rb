class Address < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  # Relations
  belongs_to :addressable, polymorphic: true

  # Validations
  validates :address_1, presence: true, length: { minimum: 2 }
  validates :zip_code, presence: true, length: { in: 2..5 }
  validates :city, presence: true, length: { in: 2..30 }
  validates :country, presence: true, length: { in: 2..30 }

  # Callback
  before_create :set_date_start, :archive_others

  private

  def set_date_start
    self.date_start ||= Date.current
  end

  def archive_others
    return if self.status == 'archived'
    self.addressable.addresses.each { |a| a.update_attributes(status: 0) }
  end
end
