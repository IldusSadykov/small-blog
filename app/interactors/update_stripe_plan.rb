class UpdateStripePlan
  include Interactor

  delegate :plan, to: :context

  def call
    stripe_plan.name = plan.name
    if stripe_plan.save
      plan.save
    else
      context.fail!(error: I18n.t("stripe.plan.failed"))
    end
  end

  private

  def stripe_plan
    @stripe_plan ||= Stripe::Plan.retrieve(plan.stripe_id)
  end
end
