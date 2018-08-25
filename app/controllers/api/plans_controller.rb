class Api::PlansController < Api::ApiController

  def index
    @plans = Plan.all
  end

  def my_plan
    @plan = Plan.where('user_id = ?', current_user.id).first
  end

  def public_profile
    @plan = Plan.find(params[:id])
  end

end
