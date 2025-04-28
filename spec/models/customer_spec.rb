require "rails_helper"

RSpec.describe Customer, type: :model do
  describe "Relationships" do
    it { is_expected.to have_many :customer_subscriptions }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :first_name }
    it { is_expected.to validate_presence_of :last_name }
    it { is_expected.to validate_presence_of :email }
    it { is_expected.to validate_presence_of :address }
  end
end
