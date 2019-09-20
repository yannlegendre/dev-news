class CreateMeetupThemes < ActiveRecord::Migration[6.0]
  def change
    create_table :meetup_themes do |t|
      t.references :meetup, null: false, foreign_key: true
      t.references :theme, null: false, foreign_key: true

      t.timestamps
    end
  end
end
