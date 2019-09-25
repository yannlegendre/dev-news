FactoryBot.define do
  factory :theme do
    sequence(:name) { |n| "theme #{n}" }
  end
end
