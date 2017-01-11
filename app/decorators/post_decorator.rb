class PostDecorator < ApplicationDecorator
  decorates_association :comments, scope: :created_at_order_desc

  STRIPE_CHECKOUT_URL = "https://checkout.stripe.com/checkout.js".freeze

  delegate :id, :title, :body, :author, :plan, :subscribed?, :comments_count

  def author_name
    object.author.full_name
  end

  def build_comment
    object.comments.build
  end

  def actions_block(current_user, subscribed_page = false)
    if PostPolicy.new(current_user, object).edit?
      h.content_tag :div, edit_button + delete_button, class: "buttons-group"
    elsif PostPolicy.new(current_user, object).can_subscribe?
      h.form_tag(h.post_subscriptions_path(object), method: "POST") { show_subscription_button }
    elsif subscribed_page
      h.link_to "Unsubscribe", h.post_subscriptions_path(post), class: "button alert delete-subscription"
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
      amount: object.plan&.amount,
      name: object.plan&.name,
      description: object.plan&.name,
      key: ENV["PUBLISHABLE_KEY"],
      label: "Subscribe to #{object.plan&.name} $#{object.plan&.amount / 100}"
    }
  end

  private

  def edit_button
    h.link_to(
      "Edit post",
      h.edit_post_path(object),
      class: "button edit-button"
    )
  end

  def delete_button
    h.link_to(
      "Delete post",
      h.post_path(object),
      class: "button alert delete-button",
      "data-method": :delete
    )
  end
end
