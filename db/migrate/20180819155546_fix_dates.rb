class FixDates < ActiveRecord::Migration[5.2]
  def change
    Measurement.all.each do |m| m.log_date = m.log_date.to_date; m.save! end
  end
end
