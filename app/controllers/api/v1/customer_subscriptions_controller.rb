class Api::V1::CustomerSubscriptionsController < ApplicationController
  def update
    customer_sub = CustomerSubscription.find(params[:id])

    if active_params == "true"
      customer_sub.status = "active"
    elsif active_params == "false"
      customer_sub.status = "inactive"
    else
      render json: ErrorSerializer.format_error(ErrorMessage.new("Value of active must be 'true' or 'false'", 422)), status: :unprocessable_entity
      return
    end
    render json: CustomerSubscriptionSerializer.new(customer_sub), status: :ok
  end

  private

  def active_params
    params.require(:active)
  end
end
