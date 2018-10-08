class Role
  attr_reader :project, :user
  DEVELOPER = :developer
  CUSTOMER = :customer
  OWNER = :owner

  def initialize(project:, user:)
    @project = project
    @user = user
  end

  def name
    role.to_s.titleize
  end

  def owner?
    role == OWNER
  end

  def developer?
    role == DEVELOPER
  end

  def customer?
    role == CUSTOMER
  end

  def member?
    role.true?
  end

  def role
    @role ||= begin
      return :owner if project.owner == user
      return :customer if project.customers.include? user
      return :developer if project.developers.include? user
      false
    end
  end

end