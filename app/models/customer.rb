class Customer < ApplicationRecord
  has_many :customer_subscriptions

  validates :first_name, :last_name, :email, :address, presence: true
end
