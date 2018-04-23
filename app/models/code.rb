class Code < ApplicationRecord

  # Relations
  belongs_to :institution
  belongs_to :category, class_name: 'CodeCategory', foreign_key: 'code_category_id'

  # Validation
  validates :content, presence: true

  # Callback
  before_create :archive_others

  def archive_others
    return if self.status == 'archived'
    self.institution.codes.each { |c| c.update_columns(status: 0)  unless c == self }
  end
end
