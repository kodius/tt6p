class AddImageToMeasurement < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :image, :string
  end
end
