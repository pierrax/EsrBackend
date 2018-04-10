class InstitutionName < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  # Relations
  belongs_to :institution, required: false

  # Validations
  validates :text, presence: true, length: { in: 2..30 }
  validates :initials, presence: true, length: { in: 2..30 }

  # Callback
  before_create :set_date_start, :archive_others

  private

  def set_date_start
    self.date_start ||= Date.current
  end

  def archive_others
    self.institution.names.each { |n| n.update_attributes(status: 0) }
  end
end
