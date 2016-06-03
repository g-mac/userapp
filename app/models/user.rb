class User < ActiveRecord::Base
  attr_accessor :password #this is needed because the table doesnt hold a 'password', only 'password_hash' and 'password_salt'; so the when the form is mapped to the model the 'password' attribute is unkown
  before_save :encrypt_password

  # EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  # validates :username, :presence => true, :uniqueness => true, :length => { :in => 3..20 }
  # validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  validates :email, :presence => true, :uniqueness => true
  validates_length_of :password, :in => 6..20, :on => :create
  validates :password, :confirmation => true #password_confirmation attr

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end