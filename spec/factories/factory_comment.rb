FactoryBot.define do
  factory :comment, class: "Comment" do
    content { "Great stuff" }
    user
    association :commentable, factory: :article
  end

  factory :reply, class: "Comment" do
    content { "Great stuff" }
    user
    association :commentable, factory: :comment
  end
end
