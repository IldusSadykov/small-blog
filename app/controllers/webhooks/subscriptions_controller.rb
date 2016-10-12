module Webhooks
  class SubscriptionsController < ApplicationController
    expose(:event) { Stripe::Event.retrieve(params[:id]) }
    respond_to :json

    def create
      result = StripeSubscriptions::EventsProcessing.call(
        event_type: event.type,
        event_object: event.data.object
      )

      if result.success?
        render status: :created, nothing: true
      else
        render status: 422, errors: result.errors
      end
    end
  end
end
