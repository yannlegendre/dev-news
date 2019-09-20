FactoryBot.define do
  factory :article do
    title { "Learning tests" }
    content { "Dolor et duis minim ea eu eiusmod enim
              deserunt anim mollit quis eiusmod anim aute irure officia
              in nostrud culpa sed excepteur aliqua amet in ut in est in
              µdeserunt nostrud adipisicing aliquip culpa consectetur non
              ex duis."}
    url { "https://www.somewebsite.com/apage" }
  end
end
