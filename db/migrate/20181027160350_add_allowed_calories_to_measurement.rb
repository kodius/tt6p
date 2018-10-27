class AddAllowedCaloriesToMeasurement < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :allowed_calories, :decimal, :precision => 15, :scale => 2

    Measurement.all.each do |m|
      plan = Plan.find_by_user_id(m.user_id)
      if plan
        m.allowed_calories = plan.total_calories
        m.save
      end
    end
  end
end
