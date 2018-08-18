class AddCaloriesToMeasurement < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :calories, :decimal, :precision => 15, :scale => 2
  end
end
