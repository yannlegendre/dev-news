FactoryBot.define do
  factory :meetup do
    sequence(:title) { |n| "titre n° #{n}" }
    sequence(:host) { |n| "host n° #{n}" }
    date_time { 10.days.from_now }
    url { "http://xxx" }
  end
end
