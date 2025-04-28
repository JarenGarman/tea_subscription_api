require "rails_helper"

RSpec.describe Tea, type: :model do
  describe "Relationships" do
    it { is_expected.to have_many :subscription_teas }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of :title }
    it { is_expected.to validate_presence_of :description }
    it { is_expected.to validate_presence_of :brew_time }
    it { is_expected.to validate_numericality_of(:brew_time).is_greater_than 0 }
    it { is_expected.to validate_presence_of :image_url }
  end
end
