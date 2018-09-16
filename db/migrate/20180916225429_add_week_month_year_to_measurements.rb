class AddWeekMonthYearToMeasurements < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :week_num,  :integer
    add_column :measurements, :month_num, :integer
    add_column :measurements, :year_num,  :integer

    add_index :measurements, [:user_id, :year_num]
    add_index :measurements, [:user_id, :month_num]
    add_index :measurements, [:user_id, :week_num]

    Measurement.find_each do |m|
      next unless m.log_date

      week, month, year = m.log_date.strftime('%W %m %Y').split(' ')
      m.update_columns(week_num: week, month_num: month, year_num: year)
    end
  end
end
