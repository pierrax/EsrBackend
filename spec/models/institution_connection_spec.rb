require 'rails_helper'

RSpec.describe InstitutionConnection, type: :model do
  it { should belong_to(:mother) }
  it { should belong_to(:daughter) }
  it { should belong_to(:category) }
  it { should validate_presence_of(:mother_id)}
  it { should validate_presence_of(:daughter_id)}
  it { should validate_presence_of(:institution_connection_category_id)}
end
