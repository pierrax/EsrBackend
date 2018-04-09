FactoryGirl.define do
  factory :category_link do
    title { FFaker::Lorem.characters(10) }
  end
end
