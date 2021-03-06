class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :description
  has_many :comments, dependent:  :destroy
  has_many :tags, dependent:  :destroy
  accepts_nested_attributes_for :tags, reject_if: :all_blank, allow_destroy: true
  paginates_per 3
  has_one_attached :thumbnail
  #has_one_attached :arquivo
  validates :thumbnail, attached: true, content_type: ['image/png', 'image/jpg', 'image/jpeg'],
                                     dimension: { width: { min: 500, max: 1920 },
                                                  height: { min: 600, max: 1080 }, message: 'is not given between dimension' }

  validates :title, length: {minimum: 5} 
  
  
  def optimized_image(image,x,y)
    
    return image.variant(resize_to_fill: [x, y]).processed if image.present?
  end

  
end
