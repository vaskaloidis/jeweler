class CreateTask  < Patterns::Service
def initialize(user)
  @user = user
end

def call


end

private

attr_reader :user
end