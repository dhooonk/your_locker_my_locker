class User < ApplicationRecord

  attr_accessor :login
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

has_one :applchemLocker, :dependent => :destroy


  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(studentNumber) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:stuN) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end
validates_format_of :studentNumber, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

  def email_required?
    false
  end
end
