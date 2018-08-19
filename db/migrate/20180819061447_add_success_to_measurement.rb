class AddSuccessToMeasurement < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :success, :boolean
    Measurement.all.each(&:save)
  end
end
