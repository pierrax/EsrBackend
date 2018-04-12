require 'rails_helper'

RSpec.describe LinkCategory, type: :model do
  it { should validate_presence_of :title }
end
