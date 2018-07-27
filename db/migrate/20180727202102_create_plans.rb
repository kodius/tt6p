class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.integer :user_id
      t.decimal :weight, :precision => 15, :scale => 2
      t.decimal :body_fat, :precision => 15, :scale => 2
      t.decimal :target_body_fat, :precision => 15, :scale => 2

      t.timestamps
    end
  end
end
