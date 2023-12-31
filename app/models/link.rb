class Link < ApplicationRecord
  belongs_to :user
  validates :url, presence: true
  validates :label, presence: true
  validates :order, numericality: { greater_than_or_equal_to: 0 }

  def self.get_next_order
    # If no links, return 1
    if Link.first.nil?
      1
    else
      Link.last.order + 1
    end
  end

  def self.reorder_links
    # Reorder all links
    Link.order(order: :asc).each_with_index do |link, index|
      link.order = index + 1
      link.save!
    end
  end
end
