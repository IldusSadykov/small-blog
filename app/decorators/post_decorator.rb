class PostDecorator < ApplicationDecorator
  decorates_association :comments, scope: :created_at_order_desc

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
      h.form_for(Subscription.new, url: h.post_subscriptions_path(object), method: "POST") do |f|
        h.javascript_include_tag("https://checkout.stripe.com/checkout.js", class: "stripe-button",
          data: {
            amount: "#{object.plan.try(:amount)}",
            name: "#{object.plan.try(:name)}",
            description: "#{object.plan.try(:name)}",
            key:"#{ENV['PUBLISHABLE_KEY']}"
          }
        )
      end
    elsif object.subscribed?(current_user)
      h.content_tag :span, "Subscribed", class: "label"
    end
  end
end
