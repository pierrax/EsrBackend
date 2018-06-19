class InstitutionName < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  # Relations
  belongs_to :institution, required: false

  # Validations
  validates :text, presence: true, length: { in: 2..100 }
  validates :initials, presence: true, length: { in: 2..30 }

  # Callback
  before_create :set_date_start, :archive_others

  private

  def set_date_start
    self.date_start ||= Date.current
  end

  def archive_others
    if self.status == 'archived'
      new_synonym = [self.institution.synonym, self.text, self.initials].compact.join(', ')
    else
      self.institution.names.each { |n| n.update_attributes(status: 0) }
      if self.institution.synonym
        new_synonym = (self.institution.synonym.split(', ') - self.institution.old_names + self.institution.old_names).join(', ')
      else
        new_synonym = [self.institution.old_names].join(', ')
      end
    end
    self.institution.update_attributes(synonym: new_synonym)
  end
end
