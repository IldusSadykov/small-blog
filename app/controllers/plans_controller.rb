class PlansController < ApplicationController
  respond_to :html

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
    stripe_id = plan_params[:name]
    plan.stripe_id = stripe_id
    plan.save
    stripe_plan = Stripe::Plan.create(
      plan_params
        .merge(id: stripe_id)
        .except(:stripe_id, :user_id)
    )
    respond_with plan
  end

  def edit
    respond_with plan
  end

  def update
    plan.save
    stripe_plan = Stripe::Plan.retrieve(plan.stripe_id)
    stripe_plan.name = plan.name
    stripe_plan.save
    respond_with plan
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
    ).merge(user_id: current_user.id)
  end
end
