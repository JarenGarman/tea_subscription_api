class Tea < ApplicationRecord
  has_many :subscription_teas

  validates :title, :description, :brew_time, :image_url, presence: true
  validates :brew_time, numericality: {greater_than: 0}
end
