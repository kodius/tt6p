class AddBodyFatToMeasurements < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :body_fat, :decimal, :precision => 15, :scale => 2
  end
end
