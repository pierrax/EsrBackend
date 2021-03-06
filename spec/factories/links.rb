FactoryGirl.define do
  factory :link do
    association :institution
    association :category, factory: :link_category
    content { FFaker::Internet.http_url }

    date_start { 10.years.ago }
    date_end { nil }
    status { 'active' }
  end
end
