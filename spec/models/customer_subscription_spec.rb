require "rails_helper"

RSpec.describe CustomerSubscription, type: :model do
  describe "Relationships" do
    it { is_expected.to belong_to :customer }
    it { is_expected.to belong_to :subscription }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :status }
    it { is_expected.to validate_presence_of :frequency }
    it { is_expected.to validate_numericality_of(:frequency).is_greater_than 0 }
  end
end
