require 'rails_helper'

RSpec.describe Institution, type: :model do
  it { should validate_presence_of :date_start }
end
