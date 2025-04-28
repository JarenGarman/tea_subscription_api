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

      it "can sort by price desc" do
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

      it "can sort by price asc" do
        get api_v1_subscriptions_path, params: {sort_by_price: "asc"}

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
          expect(sub1[:attributes][:price]).to be <= sub2[:attributes][:price]
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

  describe "Get Subscription Endpoint" do
    let(:sub) { Subscription.all.sample }

    context "with valid request" do
      it "returns all subscription with expected fields and relationships" do
        get api_v1_subscriptions_path(sub.id)

        expect(response).to have_http_status(:ok)
        json = JSON.parse(response.body, symbolize_names: true)

        expect(json[:data][:id]).to be_a String
        expect(json[:data][:type]).to eq("subscription")
        expect(json[:data][:attributes][:title]).to be_a String
        expect(json[:data][:attributes][:price]).to be_a Float
        expect(json[:data][:attributes][:image_url]).to be_a String

        customer_subs = json[:data][:attributes][:customer_subscriptions]
        expect(customer_subs.size).to eq(sub.customer_subscriptions.size)
        customer_subs.each do |customer_sub|
          expect(customer_sub[:id]).to be_a String
          expect(customer_sub[:type]).to eq("customer_subscription")
          expect(customer_sub[:attributes][:status]).to eq("active").or eq("inactive")
          customer = customer_sub[:attributes][:customer]
          expect(customer[:id]).to be_a String
          expect(customer[:type]).to eq("customer")
          expect(customer[:attributes][:first_name]).to be_a String
          expect(customer[:attributes][:last_name]).to be_a String
          expect(customer[:attributes][:email]).to be_a String
          expect(customer[:attributes][:address]).to be_a String
        end

        expect(json[:included].size).to eq(sub.teas.size)
      end
    end

    context "with invalid request" do
      it "returns an error for invalid subscription_id" do
        get api_v1_subscriptions_path(-1)

        json = JSON.parse(response.body, symbolize_names: true)

        expect(response).to have_http_status(:not_found)
        expect(json[:message]).to eq("Couldn't find Subscription with 'id'=-1")
        expect(json[:status]).to eq(404)
      end
    end
  end
end
