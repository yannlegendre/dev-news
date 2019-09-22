require 'rails_helper'

RSpec.describe ArticleTheme, type: :model do
  it "a theme can only be added once to a specific article" do
    theme = create(:theme)
    article = create(:article)
    create(:article_theme, theme: theme, article: article)
    articletheme2 = build(:article_theme, theme: theme, article: article)
    articletheme2.validate
    expect(articletheme2.errors.messages[:theme]).to include("has already been taken")
  end
end
