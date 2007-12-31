# == Schema Information
# Schema version: 12
#
# Table name: users
#
#  id                        :integer       not null, primary key
#  login                     :string(40)    not null
#  email                     :string(100)   not null
#  crypted_password          :string(40)    
#  salt                      :string(40)    
#  created_at                :datetime      not null
#  updated_at                :datetime      
#  remember_token            :string(255)   
#  remember_token_expires_at :datetime      
#  city                      :string(64)    
#  state                     :string(2)     
#  country                   :string(2)     
#  is_teacher                :boolean       
#  descr                     :string(255)   
#  referral                  :string(255)   
#  first_name                :string(255)   
#  last_name                 :string(255)   
#

require 'digest/sha1'
class User < ActiveRecord::Base
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates_presence_of     :login, :email
  validates_presence_of     :password,                   :if => :password_required?
  validates_presence_of     :password_confirmation,      :if => :password_required?
  validates_length_of       :password, :within => 4..40, :if => :password_required?
  validates_confirmation_of :password,                   :if => :password_required?
  validates_length_of       :login,    :within => 3..40
  validates_length_of       :email,    :within => 3..100
  validates_uniqueness_of   :login, :email, :case_sensitive => false
  before_save :encrypt_password

  has_many :comments, :conditions => {:deleted => false}

  has_and_belongs_to_many :roles, :class_name => "Role",
    :join_table => "user_roles_map"

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by_login(login) # need to get the salt
    u && u.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at 
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token            = encrypt("#{email}--#{remember_token_expires_at}")
    save(false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token            = nil
    save(false)
  end

  def display_name
    if first_name.blank? and last_name.blank?
      login
    else
      [first_name, last_name].join ' '
    end
  end

  # Does the user have this role?
  def has_role?(role)
    roles.map {|r| r.to_s.downcase}.include?(role.to_s.downcase)
  end

  def admin?
    has_role? 'admin'
  end

  protected
    # before filter 
    def encrypt_password
      return if password.blank?
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{login}--") if new_record?
      self.crypted_password = encrypt(password)
    end
    
    def password_required?
      crypted_password.blank? || !password.blank?
    end
end
