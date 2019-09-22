FactoryBot.define do
  factory :meetup do
    sequence(:title) { |n| "titre n° #{n}" }
    sequence(:host) { |n| "host n° #{n}" }
    date_time { 10.days.from_now }
    address { "30 rue des fleurs, 69002 Lyon" }
  end
end
