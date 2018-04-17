require 'rails_helper'

RSpec.describe InstitutionEvolution, type: :model do
  it { should belong_to(:predecessor) }
  it { should belong_to(:follower) }
  it { should belong_to(:category) }
  it { should validate_presence_of(:predecessor_id)}
  it { should validate_presence_of(:follower_id)}
  it { should validate_presence_of(:institution_evolution_category_id)}
end
