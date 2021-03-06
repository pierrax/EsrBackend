FactoryGirl.define do
  factory :address do
    addressable { |a| a.association(:institution) }
    business_name { FFaker::Lorem.characters(2) }
    address_1 { FFaker::Lorem.characters(10) }
    address_2 { FFaker::Lorem.characters(10) }
    zip_code { '75001' }
    city { 'Paris' }
    country { 'France' }
    phone { '0100110011' }
    latitude { '0.11' }
    longitude { '0.11' }
    date_start { 10.years.ago }
    date_end { nil }
    status { 'active' }
    city_code { 123 }
  end
end
