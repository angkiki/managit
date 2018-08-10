class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username
  validates_uniqueness_of :username

  has_many :project_users
  has_many :projects, through: :project_users

  has_many :features

  def self.find_by_email_or_username(input)
    if is_valid_email?(input)
      @user = User.find_by(email: input)
    else
      @user = User.find_by(username: input)
    end
  end

  private
    def self.is_valid_email?(email)
      email =~ /\A([\w+\-]\.?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
    end

end
