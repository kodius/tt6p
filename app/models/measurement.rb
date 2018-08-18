class Measurement < ApplicationRecord
  belongs_to :user
  validates_presence_of :log_date
  validates_presence_of :user_id

  def lbm
    if body_fat.present? && weight.present?
      (weight * (1 - body_fat/100.0)).round(1)
    else
      nil
    end
  end

end
