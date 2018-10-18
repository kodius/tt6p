class AddDatyTo6p < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :days_till_sixpack, :integer
  end
end
