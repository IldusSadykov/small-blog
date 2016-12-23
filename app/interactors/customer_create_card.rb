class CustomerCreateCard
  include Interactor

  delegate :current_user, :stripe_customer, :stripe_token, to: :context

  def call
    stripe_card = stripe_customer.sources.create(source: stripe_token)
    context.credit_card = create_credit_card(stripe_card)
  end

  private

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
