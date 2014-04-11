# == Schema Information
#
# Table name: users
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#  salt               :string(255)
#  admin              :boolean          default(FALSE)
#  parent             :integer
#  description        :string(255)
#  image              :string(255)
#  phone              :string(255)
#  template_name      :string(255)
#  href               :string(255)
#  color              :string(255)
#

class User < ActiveRecord::Base
  has_many :microposts, :dependent => :destroy

  attr_accessor :password

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i


  validates :name,  :presence => true,
                    :length => {:within => 4..60 }
  validates_uniqueness_of :name, message: "Must be unique"

  validates :email, :presence => true,
            :format => { :with => email_regex , on: :create },
            :uniqueness => {:case_sensitive => false}

  #validates_length_of :password, within: 6..40, allow_nil: false
  validates :password,  :presence => true,
                        :confirmation => true,
                        :length => {:within => 6..40 }

  before_save :encrypt_password

  after_create 'add_to_timeline'

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  class << self
    def authenticate(email, submitted_password)
      user = find_by_email(email)
      (user && user.has_password?(submitted_password)) ? user: nil
    end
    def authenticate_with_salt(id, cookie_salt)
      user = find_by_id(id)
      (user && user.salt == cookie_salt) ? user: nil
    end
  end

  private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end

  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end

  def encrypt(string)
    secure_hash("#{salt}--#{string}") # code here
  end

  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
  end

  def add_to_timeline
    Timeline.create!({content: "An #{self.class.to_s} was created!", timelineable_id: id, timelineable_type: self.class.to_s})
  end
end
