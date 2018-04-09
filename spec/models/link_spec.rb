require 'rails_helper'

RSpec.describe Link, type: :model do
  it { should belong_to(:institution) }
  it { should belong_to(:category) }
  it { should validate_presence_of :content }
end
