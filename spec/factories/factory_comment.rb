FactoryBot.define do
  factory :comment_on_article, class: "Comment" do
    content { "Great stuff" }
    user
    association :commentable, factory: :article
  end

  factory :reply, class: "Comment" do
    content { "Great stuff" }
    user
    association :commentable, factory: :comment_on_article
  end
end
