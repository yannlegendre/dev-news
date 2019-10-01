class AddImgUrlToArticles < ActiveRecord::Migration[6.0]
  def change
    add_column :articles, :img_url, :string, default: "https://i-love-png.com/images/no-image_7279.png"
  end
end
