class AddLbmAndCalorieTarget < ActiveRecord::Migration[5.2]
  def change
    add_column :measurements, :lean_body_mass, :decimal, :precision => 15, :scale => 2
    add_column :measurements, :target_calories, :decimal, :precision => 15, :scale => 2

    Measurement.all.each do |m|
      plan = Plan.find_by_user_id(m.user_id)
      if plan 
        m.lean_body_mass = m.lbm
        m.target_calories = plan.tdee
        m.save
      end
    end
  end
end
