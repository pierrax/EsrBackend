FactoryGirl.define do
  factory :institution_tagging do
    association :institution
    association :institution_tag

    date_start { 10.years.ago }
    date_end { nil }
    status { 1 }
  end
end
