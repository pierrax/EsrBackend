FactoryGirl.define do
  factory :code do
    association :institution
    association :category, factory: :category_code
    content { FFaker::Lorem.characters(10) }

    date_start { 10.years.ago }
    date_end { nil }
    status { 'active' }
  end
end
