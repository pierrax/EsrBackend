FactoryGirl.define do
  factory :institution_category_label do
    short_label { FFaker::Lorem.characters(10) }
    long_label  { FFaker::Lorem.characters(30) }
  end
end
