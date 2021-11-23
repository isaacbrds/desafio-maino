class Tag < ApplicationRecord
  belongs_to :post

  validates :title, presence: true, length: {minimum: 3} 
end
