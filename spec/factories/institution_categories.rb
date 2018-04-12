FactoryGirl.define do
  factory :institution_category do
    association :institution
    association :label, factory: :institution_category_label

    status { 1 }
    date_start { 10.years.ago }
    date_end { nil }
  end
end
