class Post < ApplicationRecord
  belongs_to :user
  
  has_many :favorites
  has_many :likers, through: :favorites, source: :post
  
  validates :content, presence: true, length: { maximum: 255 }
  
  mount_uploader :pictures, PictureUploader
end
