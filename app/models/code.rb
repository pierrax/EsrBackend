class Code < ApplicationRecord

  enum status: { archived: 0, active: 1 }
  # Relations
  belongs_to :institution
  belongs_to :category, class_name: 'CodeCategory', foreign_key: 'code_category_id'

  # Validation
  validates :content, presence: true

  # Callback
  before_create :archive_others

  # Scopes
  scope :from_category, -> (category_id) { where(code_category_id: category_id) }

  def archive_others
    return if self.status == 'archived'
    self.institution.codes.from_category(self.category.id).each { |c| c.update_columns(status: 0)  unless c == self }
  end
end
