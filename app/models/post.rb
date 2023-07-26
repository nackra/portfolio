class Post < ApplicationRecord
  belongs_to :user
  attachment :image
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user
  has_one :spot, dependent: :destroy
  accepts_nested_attributes_for :spot

  validates :title, presence: true
  validates :body, length: {in: 1..200}

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end
end
