class User < ApplicationRecord
  paginates_per 10

  devise :database_authenticatable
  mount_uploader :avatar, AvatarUploader
  has_many :measurements
  has_one :plan

  validates_presence_of :email
end
