require 'rails_helper'

RSpec.describe InstitutionTag, type: :model do
  it { should have_many(:institutions) }
  it { should belong_to(:category) }
  it { should validate_presence_of(:short_label)}
  it { should validate_presence_of(:long_label)}
end
