class User < ActiveRecord::Base

  before_save { self.email = email.downcase if email.present? }
  before_save { self.name = self.capitalize_names if name.present? }
  before_save { self.role ||= :member }

  def capitalize_names
    fixed_name = name.split.map do |word|
      word.capitalize
    end

    fixed_name.join(" ")
  end

  def favorite_for(post)
    favorites.where(post_id: post.id).first
  end 

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy

  before_save { self.email = email.downcase if email.present? }


  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
              presence: true,
              uniqueness: { case_sensitive: false },
              length: { minimum: 3, maximum: 254 }
    has_secure_password

    enum role: [:member, :admin]
end
