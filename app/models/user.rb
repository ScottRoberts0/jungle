class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: true
  validates :password, confirmation: true, presence: true
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 8 }
  validates :name, presence: true


  def downcase
    self.email.downcase!
  end

  before_save { name.downcase! }

  def self.authenticate_with_credentials(email, password)
    user = User.find_by email: email.delete(' ').downcase

    if user && user.authenticate(password)
      return user
    else
      return nil
    end    
  end



end
