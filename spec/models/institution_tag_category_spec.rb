require 'rails_helper'

RSpec.describe InstitutionTagCategory, type: :model do
  it { should have_many(:tags) }
  it { should validate_presence_of(:title)}
end
