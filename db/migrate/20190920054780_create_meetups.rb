class CreateMeetups < ActiveRecord::Migration[6.0]
  def change
    create_table :meetups do |t|
      t.string :title
      t.string :host
      t.string :address
      t.datetime :date_time
      t.integer :capacity

      t.timestamps
    end
  end
end
