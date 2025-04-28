require "rails_helper"

RSpec.describe "Subscriptions API", type: :request do
  describe "Get Subscriptions Endpoint" do
    context "with valid request" do
      it "returns all subscriptions with expected fields" do
        get api_v1_subscriptions_path

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].count).to eq(10)
        json[:data].each do |subscription|
          expect(subscription[:id]).to be_a String
          expect(subscription[:type]).to eq("subscription")
          expect(subscription[:attributes][:title]).to be_a String
          expect(subscription[:attributes][:price]).to be_a Float
          expect(subscription[:attributes][:image_url]).to be_a String
        end
      end

      it "can sort by price" do
        get api_v1_subscriptions_path, params: {sort_by_price: "desc"}

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data].count).to eq(10)
        json[:data].each do |subscription|
          expect(subscription[:id]).to be_a String
          expect(subscription[:type]).to eq("subscription")
          expect(subscription[:attributes][:title]).to be_a String
          expect(subscription[:attributes][:price]).to be_a Float
          expect(subscription[:attributes][:image_url]).to be_a String
        end
        json[:data].each_cons(2) do |sub1, sub2|
          expect(sub1[:attributes][:price]).to be >= sub2[:attributes][:price]
        end
      end
    end

    context "with invalid request" do
      it "returns an error for invalid sort_by_price value" do
        get api_v1_subscriptions_path, params: {sort_by_price: "dezc"}

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(json[:message]).to eq("Value of sort_by_price must be 'asc' or 'desc'")
        expect(json[:status]).to eq(422)
      end
    end
  end
end
