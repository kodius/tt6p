class CreateMeasurements < ActiveRecord::Migration[5.2]
  def change
    create_table :measurements do |t|
      t.integer :user_id
      t.decimal :weight, :precision => 15, :scale => 2
      t.datetime :date_of_measurement

      t.timestamps
    end
  end
end
