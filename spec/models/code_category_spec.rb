require 'rails_helper'

RSpec.describe CodeCategory, type: :model do
  it { should validate_presence_of :title }
end
