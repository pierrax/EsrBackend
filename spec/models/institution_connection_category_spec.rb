require 'rails_helper'

RSpec.describe InstitutionConnectionCategory, type: :model do
  it { should have_many(:connections) }
  it { should validate_presence_of(:title)}
end
