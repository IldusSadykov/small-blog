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
      h.form_for(Subscription.new, url: h.subscriptions_path, method: "POST") do |f|
        f.text_field :user_id, type: :hidden, value: current_user.id
        f.text_field :plan_id, type: :hidden, value: post.plan.id
        f.text_field :post_id, type: :hidden, value: post.id
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
