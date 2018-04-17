require 'rails_helper'

RSpec.describe InstitutionEvolutionCategory, type: :model do
  it { should have_many(:evolutions) }
  it { should validate_presence_of(:title)}
end
