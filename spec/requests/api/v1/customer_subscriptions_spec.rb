require "rails_helper"

RSpec.describe "Customer Subscriptions API", type: :request do
  describe "Patch Customer Subscriptions Endpoint" do
    let(:sub) { create(:customer_subscription, status: "active") }
    let(:params) { {active: "false"} }

    context "with valid request" do
      it "can cancel a subscription" do
        patch api_v1_customer_subscriptions_path(sub.id), params: params, as: :json

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:id]).to be_a String
        expect(json[:data][:type]).to eq("customer_subscription")
        expect(json[:data][:attributes][:status]).to eq("inactive")
      end

      it "can activate a subscription" do
        params[:active] = "true"

        patch api_v1_customer_subscriptions_path(sub.id), params: params, as: :json

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:id]).to be_a String
        expect(json[:data][:type]).to eq("customer_subscription")
        expect(json[:data][:attributes][:status]).to eq("active")
      end
    end

    context "with invalid request" do
      it "returns an error for invalid customer_subscription id" do
        patch api_v1_customer_subscriptions_path(-1), params: params, as: :json

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:not_found)
        expect(json[:message]).to eq("Couldn't find CustomerSubscription with 'id'=-1")
        expect(json[:status]).to eq(404)
      end

      it "returns an error for invalid active value" do
        params[:active] = -1

        patch api_v1_customer_subscriptions_path(sub.id), params: params, as: :json

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json[:message]).to eq("Value of active must be 'true' or 'false'")
        expect(json[:status]).to eq(422)
      end

      it "returns an error for empty active value" do
        params[:active] = ""

        patch api_v1_customer_subscriptions_path(sub.id), params: params, as: :json

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json[:message]).to eq("param is missing or the value is empty: active")
        expect(json[:status]).to eq(422)
      end
    end
  end
end
