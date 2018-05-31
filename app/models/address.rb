class Address < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  attr_accessor :skip_validation

  # Relations
  belongs_to :addressable, polymorphic: true

  # Validations
  validates :address_1, presence: true, length: { minimum: 2 }
  validates :zip_code, presence: true, length: { in: 2..5 }
  validates :city, presence: true, length: { in: 2..30 }
  validates :country, presence: true, length: { in: 2..30 }

  # Callback
  before_create :set_date_start, :archive_others

  geocoded_by :full_address
  after_validation :geocode, if: ->(obj){ obj.address_1.present? and (obj.address_1_changed? || obj.address_2_changed? || obj.city_changed? || obj.zip_code_changed?) }

  def full_address
    "#{address_1} #{address_2} #{zip_code} #{city} #{country}"
  end

  def valid_attributes?(*attributes)
    attributes.each do |attribute|
      self.class.validators_on(attribute).each do |validator|
        validator.validate_each(self, attribute, send(attribute))
      end
    end
    errors.none?
  end

  def base_valid?
    valid_attributes?(:address_1) && valid_attributes?(:zip_code) && valid_attributes?(:city) && valid_attributes?(:country)
  end
  
  private

  def set_date_start
    self.date_start ||= Date.current
  end

  def archive_others
    return if self.status == 'archived'
    self.addressable.addresses.each { |a| a.update_attributes(status: 0) }
  end
end
