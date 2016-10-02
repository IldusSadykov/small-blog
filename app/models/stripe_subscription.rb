class StripeSubscription < SimpleDelegator
  ATTRIBUTES = %i(
    stripe_id
    cancel_at_period_end
    canceled_at
    created
    current_period_end
    current_period_start
    ended_at
    livemode
    quantity
    start
    status
    trial_end
    trial_start
    plan_id
  )

  def as_json(options = {})
    attrs = options[:only] ? options[:only] : ATTRIBUTES
    attrs.reduce({}) do |hash, attr|
      next hash unless public_methods.include?(attr)
      hash[attr] = public_send(attr)
      hash
    end
  end

  def stripe_id
    id
  end

  def plan_id
    Plan.find_by(stripe_id: plan.id).try(:id)
  end

  def created
    Time.at(super) if super
  end

  def current_period_end
    Time.at(super) if super
  end

  def current_period_start
    Time.at(super) if super
  end

  def ended_at
    Time.at(super) if super
  end

  def start
    Time.at(super) if super
  end
end
