class User < ApplicationRecord
  has_many :owner_projects, class_name: 'Project', inverse_of: 'owner', dependent: :destroy
  has_many :project_customers, dependent: :destroy
  has_many :customer_projects, source: :project, through: :project_customers, dependent: :destroy
  has_many :project_developers, dependent: :destroy
  has_many :developer_projects, source: :project, through: :project_developers, dependent: :destroy
  has_many :notes, class_name: 'Note', inverse_of: 'author', dependent: :destroy
  has_many :payments, dependent: :nullify
  mount_uploader :image, AvatarUploader

  accepts_nested_attributes_for :customer_projects
  accepts_nested_attributes_for :owner_projects

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  # Devise modules. Others are: :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable, :omniauthable

  # @param [Project] project
  # @return [String] role
  def role(project)
    # Role::OWNER if project.owner == self
    # Role::CUSTOMER if project.customers.include? self
    # Role::DEVELOPER if project.developers.include? self
    :owner if project.owner == self
    :customer if project.customers.include? self
    :developer if project.developers.include? self
    false
  end

  # @param [String] email
  #   # @return [String] role
  def self.get_account(email)
    where(email: email).first if account_exists? email
    false
  end

  # @param [String] email
  def self.account_exists?(email)
    true unless where(email: email).empty?
    false
  end

  def full_name
    first_name + ' ' + last_name
  end

  def is_god?
    email == 'vas.kaloidis@gmail.com'
  end

  def first_last_name_email
    "#{first_name} #{last_name} - #{email}"
  end

  def invitations
    Invitation.where(email: email).all
  end

  # class << self
  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def self.current_user
    Thread.current[:current_user]
  end

  # end

  def self.god
    User.where(email: 'vas.kaloidis@gmail.com').first
  end

  def github_installed?
    !oauth.nil? && !oauth.empty?
  end

end
