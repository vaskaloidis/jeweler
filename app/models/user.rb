class User < ApplicationRecord
  has_many :owner_projects, class_name: 'Project', inverse_of: 'owner', dependent: :destroy
  has_many :project_customers, dependent: :destroy
  has_many :customer_projects, source: :project, through: :project_customers, dependent: :destroy
  has_many :project_developers, dependent: :destroy
  has_many :developer_projects, source: :project, through: :project_developers, dependent: :destroy
  has_many :notes, class_name: 'Note', inverse_of: 'author', dependent: :destroy
  has_many :payments, dependent: :nullify

  # TODO: Fix these task relationships
  # has_many :tasks, inverse_of: 'assigned_to', dependent: :nullify
  # has_many :created_tasks, inverse_of: 'created_by', dependent: :nullify

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
  # @return [Role] role
  def role(project)
    Role.new(project: project, user: self)
  end

  # @param [String] email
  # @return [String] role
  def self.get_account(email)
    return where(email: email).first if account_exists? email
    false
  end

  # @param [String] email
  def self.account_exists?(email)
    return true unless where(email: email).all.empty?
    false
  end

  # @return [String] full_name
  def full_name
    first_name + ' ' + last_name
  end

  # @return [Boolean] is-the-god?
  def is_god?
    email == 'vas.kaloidis@gmail.com'
  end

  # @return [String] first-last-name-and-email
  def first_last_name_email
    "#{first_name} #{last_name} - #{email}"
  end

  # @return [Invitation] role
  def invitations
    Invitation.where(email: email).all
  end

  def github
    GitHubUser.new(self)
  end

  # class << self
  def self.god
    User.where(email: 'vas.kaloidis@gmail.com').first
  end

  # TODO: Verify if User.current_user is smart to do
  def self.current_user=(user)
    Thread.current[:current_user] = user
  end

  def self.current_user
    Thread.current[:current_user]
  end

end
