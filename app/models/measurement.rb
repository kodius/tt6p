class Measurement < ApplicationRecord
  belongs_to :user
  validates_presence_of :log_date
  validates_presence_of :user_id

  before_save :set_success

  def lbm
    if body_fat.present? && weight.present?
      (weight * (1 - body_fat/100.0)).round(1)
    else
      nil
    end
  end

  def set_success
    plan = Plan.where("user_id = ?", user_id).first
    if calories.present?
      if calories <= plan.total_calories
        self.success = true
      else
        self.success = false
      end
    end
  end

end
