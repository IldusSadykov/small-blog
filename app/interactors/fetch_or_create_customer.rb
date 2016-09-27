class FetchORCreateCustomer
  include Interactor

  delegate :current_user, :stripe_token, :stripe_email, to: :context

  def call
    context.stripe_id = fetch_or_create_customer
  end

  private

  def fetch_or_create_customer
    current_user.stripe_customer_id? ? fetch : create
  end

  def create
    current_user.update(stripe_customer_id: created_stripe_customer.id)
    current_user.stripe_customer_id
  end

  def fetch
    if Stripe::Customer.retrieve(current_user.stripe_customer_id)
      current_user.stripe_customer_id
    end
  end

  def created_stripe_customer
    Stripe::Customer.create(
      source: stripe_token,
      email: stripe_email
    )
  end
end
