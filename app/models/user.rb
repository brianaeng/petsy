class User < ActiveRecord::Base
  has_many :products
  has_many :orders
  validates :email, :uid, :provider, :authenticated, presence: true

  validate :email_at_symbol
  validate :avatar_url

  def self.build_from_github(auth_hash)
    user       = User.new
    user.uid   = auth_hash[:uid]
    user.provider = 'github'
    user.name  = auth_hash['info']['name']
    user.email = auth_hash['info']['email']
    user.avatar = auth_hash['extra']['raw_info']['avatar_url']
    user.authenticated = true

    return user
  end

  def email_at_symbol
    if self.email != nil
      unless self.email.include?("@")
        errors.add(:email, "Email address must include @")
      end
    end
  end

  def avatar_url
    if self.avatar != nil && !self.avatar.include?(".com")
      errors.add(:avatar, "Avatar link must be a .com url")
    end
  end
end
