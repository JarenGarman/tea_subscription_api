class CustomerSubscription < ApplicationRecord
  belongs_to :customer
  belongs_to :subscription

  validates :status, :frequency, presence: true
  validates :frequency, numericality: {greater_than: 0}
end
