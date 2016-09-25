class FetchORCreateCustomer
  include Interactor

  delegate :current_user, :stripe_token, :stripe_email, to: :context

  def call
    context.customer = fetch_or_create_customer
  end

  private

  def fetch_or_create_customer
    current_user.update(customer: created_customer) unless current_user.customer
    current_user.customer
  end

  def stripe_customer
    Stripe::Customer.create(
      source: stripe_token,
      email: stripe_email
    )
  end

  def created_customer
    Customer.create(customer_params(stripe_customer))
  end

  def customer_params(entity)
    {
      stripe_id: entity.id,
      account_balance: entity.account_balance,
      created: Time.at(entity.created),
      currency: entity.currency,
      description: entity.description,
      email: entity.email,
      livemode: entity.livemode
    }
  end
end
