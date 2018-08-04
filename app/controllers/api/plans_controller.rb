class Api::PlansController < Api::ApiController

  def index
    @plans = Plan.where("user_id = ?", current_user.id)
  end

end
