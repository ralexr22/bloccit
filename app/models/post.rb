class Post < ActiveRecord::Base
  belongs_to :topic
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :labelings, as: :labelable
  has_many :labels, through: :labelings
  has_many :favorites, dependent: :destroy

  after_create :create_favorite, :send_user_email

  default_scope { order('rank DESC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  def up_votes
    votes.where(value: 1).count
  end

  def down_votes
    votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
    age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
    new_rank = points + age_in_days
    update_attribute(:rank, new_rank)
  end


  scope :ordered_by_title, -> { order 'title DESC' }
  scope :ordered_by_reverse_created_at, -> { order 'created ASC' }

private

 def create_favorite
   post.user.create
 end

 def send_user_email
   post.favorites.each do |favorite|
     FavoriteMailer.new_post(favorite.user, post, self).deliver_now
  end 
 end
end
