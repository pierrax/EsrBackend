FactoryGirl.define do
  factory :link_category do
    title { FFaker::Lorem.characters(10) }
    position { rand(10) }
  end
end
