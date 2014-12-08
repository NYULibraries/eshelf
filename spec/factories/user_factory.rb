# User factory
FactoryGirl.define do
  factory :user do
    sequence(:username) { |n| "developer#{n}"}
    email 'developer@example.com'
    firstname 'Dev'
    lastname 'Eloper'
    password_salt { Authlogic::Random.hex_token }
    crypted_password { Authlogic::CryptoProviders::Sha512.encrypt("#{username}#{password_salt}") }
    persistence_token { Authlogic::Random.hex_token }
    trait :nyu_aleph_attributes do
      user_attributes do
        {
          nyuidn: (ENV['BOR_ID'] || 'BOR_ID'),
          primary_institution: :NYU,
          institutions: [:NYU],
          bor_status: '51'
        }
      end
    end
  end
end
