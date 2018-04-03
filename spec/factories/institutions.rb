FactoryGirl.define do
  factory :institution, class: 'Institution' do
    # association :addressable, factory: :address
    # association :name, factory: :institution_name
    date_start { 10.years.ago }
    date_end { nil }

    after(:create) do |institution|
      create(:institution_name, institution_id: institution.id)
      create(:address, addressable_type: 'Institution', addressable_id: institution.id)
    end
  end
end
