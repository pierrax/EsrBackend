FactoryGirl.define do
  factory :code_category do
    title { FFaker::Lorem.characters(10) }
  end
end
