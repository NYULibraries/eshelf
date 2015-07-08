# User factory
FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "developer#{n}"}
    email 'developer@example.com'
    firstname 'Dev'
    lastname 'Eloper'
    trait :nyu_aleph_attributes do
      aleph_id: (ENV['BOR_ID'] || 'BOR_ID')
      institution_code: 'NYU'
      patron_status: '51'
    end
  end
end
