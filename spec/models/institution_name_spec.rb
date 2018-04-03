require 'rails_helper'

RSpec.describe InstitutionName, type: :model do
  it { should belong_to(:institution) }
  it { should validate_length_of(:text).is_at_least(2).is_at_least(2) }
  it { should validate_length_of(:text).is_at_most(30).is_at_most(30) }
end
