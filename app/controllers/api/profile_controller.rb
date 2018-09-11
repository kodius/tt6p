class Api::ProfileController < Api::ApiController
  def my_profile
    @user = current_user
  end

  def change_avatar
    current_user.avatar = params[:image]
    current_user.save!
  end
end