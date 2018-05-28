FactoryGirl.define do
  factory :institution, class: 'Institution' do
    # association :addressable, factory: :address
    # association :name, factory: :institution_name
    date_start { 10.years.ago }
    date_end { nil }
    synonym { FFaker::Lorem.words(10) }

    after(:create) do |institution|
      create(:institution_name, institution_id: institution.id)
      create(:address, addressable_type: 'Institution', addressable_id: institution.id)
    end

    trait :with_predecessors do
      after(:create) do |institution|
        create(:institution_evolution, follower_id: institution.id)
        create(:institution_evolution, follower_id: institution.id)
      end
    end

    trait :with_code_uai do
      after(:create) do |institution|
        code_uai = CodeCategory.where(title: 'uai').first || create(:code_category, title: 'uai')
        create(:code, institution: institution, code_category_id: code_uai.id)
      end
    end
  end
end
