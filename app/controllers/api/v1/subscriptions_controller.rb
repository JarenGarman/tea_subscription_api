class Api::V1::SubscriptionsController < ApplicationController
  def index
    if sort_params[:sort_by_price] == "desc"
      subs = Subscription.order(price: :desc)
    elsif sort_params[:sort_by_price] == "asc"
      subs = Subscription.order(price: :asc)
    elsif sort_params[:sort_by_price].present?
      render json: ErrorSerializer.format_error(ErrorMessage.new("Value of sort_by_price must be 'asc' or 'desc'", 422)), status: :unprocessable_entity
      return
    else
      subs = Subscription.all
    end
    render json: SubscriptionSerializer.new(subs, {fields: {subscription: [:title, :price, :image_url]}}), status: :ok
  end

  def show
    render json: SubscriptionSerializer.new(Subscription.find(params[:id]), {include: [:teas]})
  end

  private

  def sort_params
    params.permit(:sort_by_price)
  end
end
