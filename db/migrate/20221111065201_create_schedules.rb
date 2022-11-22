class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.integer :end_user_id
      t.string :title
      t.text :body
      t.integer :year
      t.integer :month
      t.integer :day
      t.string :location
      t.timestamps
    end
  end
end
