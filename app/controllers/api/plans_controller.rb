class Api::PlansController < Api::ApiController
  def index
    @plans = Plan.all
  end

  def my_plan
    @plan = current_user.plan
  end

  def public_profile
    @plan = Plan.find_by_id(params[:id])
  end

  def update_plan
    @plan = current_user.plan || Plan.new
    @plan.user_id = current_user.id
    @plan.update_attributes(plan_params)
    @plan.save!
  end

  def active_plans
    # tko misli da je ovo elegantnije od raw SQL-a???
    # sere mi se  :)
    active_user_ids = Measurement.select('user_id').group(:user_id).having('MAX(log_date) >= ?', DateTime.now - 1.month).pluck(:user_id)
    @plans = Plan.where('user_id in (?)', active_user_ids)
  end

  private

  def plan_params
    params.require('plan').permit(:weight, :body_fat, :target_body_fat, :height, :age, :gender, :activity_level)
  end
end
