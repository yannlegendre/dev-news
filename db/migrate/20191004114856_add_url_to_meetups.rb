class AddUrlToMeetups < ActiveRecord::Migration[6.0]
  def change
    add_column :meetups, :url, :string
  end
end
