class CreatePlan
  include Interactor

  delegate :current_user, :plan, to: :context

  def call
    plan.user = current_user
    plan.stripe_id = plan.name
    context.fail!(error: I18n.t("stripe.plan.failed")) unless plan.valid? && stripe_plan
    plan.save
  end

  private

  def stripe_plan
    @stripe_plan ||= Stripe::Plan.create(
      plan.slice(:name, :currency, :amount, :interval)
      .merge(id: plan.stripe_id)
    )
  end
end
