class CreateDiaries < ActiveRecord::Migration[5.1]
  def change
    create_table :diaries do |t|
      t.string :name
      t.integer :user_id

      t.timestamps
    end
  end
end
