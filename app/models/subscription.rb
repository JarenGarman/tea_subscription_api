class Subscription < ApplicationRecord
  has_many :subscription_teas
  has_many :teas, through: :subscription_teas
  has_many :customer_subscriptions

  validates :title, :price, :image_url, presence: true
  validates :price, numericality: {greater_than: 0}
end
