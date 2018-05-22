class User < ApplicationRecord
  has_many :owner_projects, class_name: 'Project', inverse_of: 'owner', dependent: :destroy
  has_many :notes, class_name: 'Note', inverse_of: 'author', dependent: :destroy
  has_many :project_customers, dependent: :destroy
  has_many :customer_projects, :source => :project, :through => :project_customers, dependent: :destroy

  mount_uploader :image, AvatarUploader

  has_many :payments, dependent: :nullify

  accepts_nested_attributes_for :customer_projects
  accepts_nested_attributes_for :owner_projects

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  # Include default devise modules. Others available are: :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable, :omniauthable

  def full_name
    return self.first_name + ' ' + self.last_name
  end

  def is_god?
    if self.email == 'vas.kaloidis@gmail.com'
      return true
    else
      return false
    end
  end

  def first_last_name_email
    "#{first_name} #{last_name} - #{email}"
  end

  def invitations
    return Invitation.where(email: self.email).all
  end

  # class << self
    def self.current_user=(user)
      Thread.current[:current_user] = user
    end

    def self.current_user
      Thread.current[:current_user]
    end
  # end

end
