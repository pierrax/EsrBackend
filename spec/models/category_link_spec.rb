require 'rails_helper'

RSpec.describe CategoryLink, type: :model do
  it { should validate_presence_of :title }
end
