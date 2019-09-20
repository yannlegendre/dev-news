FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "toto#{n}@gmail.com" }
    password { 'azerty' }
  end
end
