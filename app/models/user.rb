class User < ApplicationRecord
  has_many :orders
  before_validation :set_default_username

  private

  def set_default_username
    self.username ||= "guest"
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  #validates :username, presence: true, uniqueness: true
  validates :username, presence: true
end
