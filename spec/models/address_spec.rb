require 'rails_helper'

RSpec.describe Address, type: :model do
  it { should belong_to(:addressable)}
  it { should validate_presence_of :address_1 }
  it { should validate_presence_of :zip_code }
  it { should validate_presence_of :city }
  it { should validate_presence_of :country }
  it { should validate_length_of(:address_1).is_at_least(2) }
  it { should validate_length_of(:zip_code).is_at_least(2).is_at_most(5) }
  it { should validate_length_of(:city).is_at_least(2).is_at_most(30) }
  it { should validate_length_of(:country).is_at_least(2).is_at_most(30) }
end
