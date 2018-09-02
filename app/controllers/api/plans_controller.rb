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

  def update_plan
    pp plan_params
    Plan.where("user_id = ?", current_user).delete_all
    @plan = Plan.create(plan_params)
    @plan.user_id = current_user.id
    @plan.save!
  end

  private

  def plan_params
    params.require('plan').permit(:weight, :body_fat, :target_body_fat, :height, :age, :gender, :activity_level)
  end

end
