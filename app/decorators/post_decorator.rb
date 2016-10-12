class PostDecorator < ApplicationDecorator
  decorates_association :comments, scope: :created_at_order_desc

  STRIPE_CHECKOUT_URL = "https://checkout.stripe.com/checkout.js".freeze

  delegate :id, :title, :body, :author, :plan, :subscribed?

  def author_name
    object.author.full_name
  end

  def build_comment
    object.comments.build
  end

  def actions_block(current_user)
    if PostPolicy.new(current_user, object).edit?
      h.link_to "Edit object", h.edit_post_path(object), class: "button edit-button"
    elsif PostPolicy.new(current_user, object).can_subscribe?
      h.form_tag(h.post_subscriptions_path(object), method: "POST") { show_subscription_button }
    elsif object.subscribed?(current_user)
      h.content_tag :span, "Subscribed", class: "label"
    end
  end

  def show_subscription_button
    h.javascript_include_tag(
      STRIPE_CHECKOUT_URL,
      class: "stripe-button",
      data: checkout_info
    )
  end

  def checkout_info
    {
      amount: object.plan.try(:amount),
      name: object.plan.try(:name),
      description: object.plan.try(:name),
      key: ENV["PUBLISHABLE_KEY"],
      label: "Subscribe"
    }
  end
end
