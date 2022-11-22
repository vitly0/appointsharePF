class CreateAttends < ActiveRecord::Migration[6.1]
  def change
    create_table :attends do |t|
      t.references :end_user, null: false, foreign_key: true
      t.references :schedule, null: false, foreign_key: true
      t.timestamps
    end
  end
end
