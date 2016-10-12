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
  ).freeze

  def as_json(options = {})
    attrs = options[:only] ? options[:only] : ATTRIBUTES
    attrs.each_with_object({}) do |attr, hash|
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
    Time.zone.at(super) if super
  end

  def current_period_end
    Time.zone.at(super) if super
  end

  def current_period_start
    Time.zone.at(super) if super
  end

  def ended_at
    Time.zone.at(super) if super
  end

  def start
    Time.zone.at(super) if super
  end
end
