class Link < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :label, presence: true
  validates :order, numericality: { greater_than_or_equal_to: 0 }
end
