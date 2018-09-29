class RecalcAllChartData < ActiveRecord::Migration[5.2]
  def change
    Measurement.all.each(&:save!)
  end
end
