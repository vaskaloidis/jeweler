class User < ApplicationRecord
  has_many :owner_projects, class_name: 'Project', inverse_of: 'owner'
  has_many :project_customers
  has_many :customer_projects, :source => :project, :through => :project_customers

  accepts_nested_attributes_for :customer_projects
  accepts_nested_attributes_for :owner_projects

  validates :first_name, :presence => true
  validates :last_name, :presence => true

  # attr_accessor :first_name, :last_name

  # Include default devise modules. Others available are:
  #  :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :confirmable
end
