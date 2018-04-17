FactoryGirl.define do
  factory :institution_evolution do
    association :predecessor, factory: :institution
    association :follower, factory: :institution
    association :category, factory: :institution_evolution_category

    date { 1.year.ago }
  end
end
