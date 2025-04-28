require "rails_helper"

RSpec.describe Subscription, type: :model do
  describe "Relationships" do
    it { is_expected.to have_many :subscription_teas }
    it { is_expected.to have_many(:teas).through :subscription_teas }
    it { is_expected.to have_many :customer_subscriptions }
    it { is_expected.to have_many(:customers).through :customer_subscriptions }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :price }
    it { is_expected.to validate_numericality_of(:price).is_greater_than 0 }
    it { is_expected.to validate_presence_of :image_url }
  end
end
