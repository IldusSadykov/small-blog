class FetchORCreateCustomer
  include Interactor

  delegate :current_user, :stripe_email, to: :context

  def call
    context.customer = fetch_or_create_customer
  end

  private

  def fetch_or_create_customer
    current_user.stripe_customer_id? ? fetch : create
  end

  def create
    current_user.update(stripe_customer_id: created_stripe_customer.id)
    created_stripe_customer
  end

  def fetch
    @customer ||= Stripe::Customer.retrieve(current_user.stripe_customer_id)
  end

  def created_stripe_customer
    @customer ||= Stripe::Customer.create(
      email: stripe_email
    )
  end
end
