# User factory
FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "developer#{n}"}
    email 'developer@example.com'
    firstname 'Dev'
    lastname 'Eloper'

    trait :nyu_aleph_attributes do
      aleph_id (ENV['BOR_ID'] || 'BOR_ID')
      institution_code 'NYU'
      patron_status '51'
    end

    factory :nysid_user do
      institution_code 'NYSID'
    end
  end
end
