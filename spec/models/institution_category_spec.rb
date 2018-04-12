require 'rails_helper'

RSpec.describe InstitutionCategory, type: :model do
  it { should belong_to(:institution) }
  it { should belong_to(:label) }
end
