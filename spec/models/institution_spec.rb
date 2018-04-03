require 'rails_helper'

RSpec.describe Institution, type: :model do
  it { should have_many(:names) }
  it { should have_many(:addresses) }
  it { should validate_presence_of :date_start }
end
