class Api::PlansController < Api::ApiController
  def index
      plan = Plan.where("user_id = ?", current_user.id)

      render json: plan.to_json
  end

end
