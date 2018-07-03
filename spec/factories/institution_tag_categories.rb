FactoryGirl.define do
  factory :institution_tag_category do
    title { FFaker::Lorem.characters(10) }
    origin  { FFaker::Lorem.characters(20) }
    position { rand(10) }
  end
end
