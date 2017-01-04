module Webhooks
  class SubscriptionsController < ApplicationController
    skip_before_action :verify_authenticity_token

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
