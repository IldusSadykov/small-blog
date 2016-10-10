class FetchORCreateCustomer
  include Interactor

  delegate :current_user, :stripe_token, :stripe_email, to: :context

  def call
    context.customer = fetch_or_create_customer
  end

  private

  def fetch_or_create_customer
    current_user.stripe_customer_id? ? fetch : create
  end

  def create
    current_user.update(stripe_customer_id: created_stripe_customer.id)
    create_credit_card(@customer.sources.data.last)
    created_stripe_customer
  end

  def fetch
    @customer ||= Stripe::Customer.retrieve(current_user.stripe_customer_id)
    stripe_card = @customer.sources.create(source: stripe_token)
    create_credit_card(stripe_card)
    @customer
  end

  def created_stripe_customer
    @customer ||= Stripe::Customer.create(
      source: stripe_token,
      email: stripe_email
    )
  end

  def create_credit_card(stripe_card)
    current_user.credit_cards.create(credit_card_params(stripe_card))
  end

  def credit_card_params(credit_card)
    {
      stripe_id: credit_card.id,
      brand: credit_card.brand,
      last4: credit_card.last4,
      name: credit_card.name
    }
  end
end
