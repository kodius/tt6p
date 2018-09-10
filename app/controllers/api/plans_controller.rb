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
    Plan.where("user_id = ?", current_user).delete_all
    @plan = Plan.create(plan_params)
    @plan.user_id = current_user.id
    @plan.save!
  end

  def active_plans
    # tko misli da je ovo elegantnije od raw SQL-a???
    # sere mi se  :)
    active_user_ids = Measurement.select("user_id").group(:user_id).having("MAX(log_date) >= ?", DateTime.now - 1.week).pluck(:user_id)
    @plans = Plan.where("user_id in (?)", active_user_ids)
  end

  private

  def plan_params
    params.require('plan').permit(:weight, :body_fat, :target_body_fat, :height, :age, :gender, :activity_level)
  end

end
