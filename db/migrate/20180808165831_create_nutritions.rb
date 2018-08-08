class CreateNutritions < ActiveRecord::Migration[5.2]
  def change
    create_table :nutritions do |t|
      t.integer :user_id
      t.datetime :date_of_log
      t.string :meal
      t.decimal :calories, :precision => 15, :scale => 2
      t.decimal :fat, :precision => 15, :scale => 2
      t.decimal :protein, :precision => 15, :scale => 2
      t.decimal :carbohydrates, :precision => 15, :scale => 2
      t.string :note

      t.timestamps
    end
  end
end
