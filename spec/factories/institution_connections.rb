FactoryGirl.define do
  factory :institution_connection do
    association :mother, factory: :institution
    association :daughter, factory: :institution
    association :category, factory: :institution_connection_category

    date { 1.year.ago }
  end
end
