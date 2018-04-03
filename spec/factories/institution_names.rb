FactoryGirl.define do
  factory :institution_name do
    association :institution
    text { FFaker::Lorem.characters(20) }
    initials { FFaker::Lorem.characters(10) }
    date_start { 10.years.ago }
    date_end { nil }
    status { 'active' }
  end
end
