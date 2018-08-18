class Measurement < ApplicationRecord
  belongs_to :user
  validates_presence_of :log_date
  validates_presence_of :user_id
end
