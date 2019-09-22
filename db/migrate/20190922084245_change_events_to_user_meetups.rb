class ChangeEventsToUserMeetups < ActiveRecord::Migration[6.0]
  def change
    rename_table :events, :user_meetups
  end
end
