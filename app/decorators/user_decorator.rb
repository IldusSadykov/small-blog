class UserDecorator < ApplicationDecorator
  delegate :id, :full_name, :email, :subscription_plans, :subscriptions

  def full_name_with_email
    "#{object.full_name} (#{object.email})"
  end

  def plans_list
    object.plans.map do |plan|
      [plan.name, plan.id]
    end
  end
end
