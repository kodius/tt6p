class Api::ProfileController < Api::ApiController
  def my_profile
    @user = current_user
  end
end