module Webhooks
  class SubscriptionsController < ApplicationController
    expose(:event) { Stripe::Event.retrieve(params[:id]) }
    respond_to :json

    def create
      result = StripeSubscriptions::EventsProcessing.call(
        event: event
      )

      if result.success?
        render status: :created, nothing: true
      else
        render status: 422, errors: result.errors
      end
    end
  end
end
