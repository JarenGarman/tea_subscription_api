require "rails_helper"

RSpec.describe SubscriptionTea, type: :model do
  describe "Relationships" do
    it { is_expected.to belong_to :tea }
    it { is_expected.to belong_to :subscription }
  end
end
