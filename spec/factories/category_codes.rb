FactoryGirl.define do
  factory :category_code do
    title { FFaker::Lorem.characters(10) }
  end
end
