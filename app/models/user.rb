class User < ActiveRecord::Base
  before_save { self.email = email.downcase if email.present? }
  before_save { self.name = self.capitalize_names if name.present? }

  def capitalize_names
    fixed_name = name.split.map do |word|
      word.capitalize
    end

    fixed_name.join(" ")
  end

  validates :name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :password, presence: true, length: { minimum: 6 }, unless: :password_digest
  validates :password, length: { minimum: 6 }, allow_blank: true
  validates :email,
              presence: true,
              uniqueness: { case_sensitive: false },
              length: { minimum: 3, maximum: 254 }
    has_secure_password

end
