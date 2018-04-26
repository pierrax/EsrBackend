FactoryGirl.define do
  factory :institution_tag do
    association :category, factory: :institution_tag_category
    short_label { FFaker::Lorem.characters(10) }
    long_label  { FFaker::Lorem.characters(30) }

    status { 1 }
  end
end
