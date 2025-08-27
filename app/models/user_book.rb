class UserBook < ApplicationRecord
  belongs_to :user
  belongs_to :book

  # Status ko validate karenge instead of enum
  validates :status, inclusion: { in: %w[reading completed wishlist] }
end
