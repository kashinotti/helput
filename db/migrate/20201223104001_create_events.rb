class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.datetime :start_date, null: false
      t.datetime :end_date, null: false
      t.timestamps
    end
  end
end
