class PlansController < ApplicationController
  respond_to :html

  before_action :authenticate_user!

  expose_decorated(:plan, attributes: :plan_params)
  expose_decorated(:plans) { current_user.plans }

  def new
    respond_with plan
  end

  def index
    respond_with plans
  end

  def show
    respond_with plan
  end

  def create
    result = CreatePlan.call(
      current_user: current_user,
      plan: plan
    )

    if result.success?
      respond_with plan
    else
      flash[:error] = result.error
      respond_with plan
    end
  end

  def edit
    respond_with plan
  end

  def update
    result = UpdateStripePlan.call(plan: plan)
    if result.success?
      respond_with plan
    else
      flash[:error] = result.error
      respond_with plan
    end
  end

  def destroy
    plan.destroy
    redirect_to plans_path
  end

  private

  def plan_params
    params
      .require(:plan)
      .permit(
        :name,
        :currency,
        :amount,
        :interval
      )
  end
end
