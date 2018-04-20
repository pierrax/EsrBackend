FactoryGirl.define do
  factory :institution_tagging do
    association :institution
    association :institution_tag
  end
end
