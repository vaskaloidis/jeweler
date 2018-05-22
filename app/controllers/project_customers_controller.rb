class ProjectCustomersController < ApplicationController
  before_action :set_project_customer,
                only: [:verify_owner, :show, :edit, :update, :destroy]
  before_action :verify_owner,
                only: [:create, :edit, :update, :destroy]

  def create_customer_inline
    logger.debug("Creating Customer AJAX")
    # TODO: Maybe move this Invitation feature to settings (Invite existing Jeweler users, or simply add them)

    email = params[:email]
    @email = email
    project = Project.find(params[:project_id])

    # Check if User is already a member of this project
    if project.is_customer? email
      @already_customer = true
    else
      @already_customer = false
      # Check if Invitation exists already
      if project.invitations.where(email: email).empty?
        @invitation_exists = false

        @invitation = Invitation.new
        @invitation.project = project
        @invitation.email = email
        @invitation.save

        if User.account_exists? email
          logger.debug("User does not exist, (sending an invitation email): " + email)
          # TODO: Implement Mailer with delayed job
          UserInviteMailer.with(email: email, project: project.id).invite_user.deliver_now
          @user_invited = true
        else
          logger.debug("User exists (no invitation email): " + email)
          @user_invited = false
        end

        project.invitations.reload
      else
        @invitation_exists = true
      end
    end
    @project = project

    respond_to do |format|
      format.js
    end
  end

  def leave_project
    user = User.find(params[:user_id])
    project = Project.find(params[:project_id])

    project.customers.delete(user)

    respond_to do |format|
      format.html {redirect_to root_path, notice: 'You have left the project.'}
    end
  end

  def remove_customer_inline
    user = User.find(params[:user_id])
    project = Project.find(params[:project_id])

    project.customers.delete(user)

    project.reload
    @project = project

    respond_to do |format|
      format.js
    end
  end

  # GET /project_customers
  # GET /project_customers.json
  def index
    @project = Project.find(params[:project_id])
  end

  # GET /project_customers/1
  # GET /project_customers/1.json
  def show
  end

  # GET /project_customers/new
  def new
    @project_customer = ProjectCustomer.new
  end

  # GET /project_customers/1/edit
  def edit
  end

  # POST /project_customers
  # POST /project_customers.json
  def create
    @project_customer = ProjectCustomer.new(project_customer_params)

    respond_to do |format|
      if @project_customer.save
        format.html {redirect_to @project_customer, notice: 'Project customer was successfully created.'}
        format.json {render :show, status: :created, location: @project_customer}
      else
        format.html {render :new}
        format.json {render json: @project_customer.errors, status: :unprocessable_entity}
      end
    end
  end

  # PATCH/PUT /project_customers/1
  # PATCH/PUT /project_customers/1.json
  def update
    respond_to do |format|
      if @project_customer.update(project_customer_params)
        format.html {redirect_to @project_customer, notice: 'Project customer was successfully updated.'}
        format.json {render :show, status: :ok, location: @project_customer}
      else
        format.html {render :edit}
        format.json {render json: @project_customer.errors, status: :unprocessable_entity}
      end
    end
  end

  # DELETE /project_customers/1
  # DELETE /project_customers/1.json
  def destroy
    @project_customer.destroy
    respond_to do |format|
      format.html {redirect_to project_customers_url, notice: 'Project customer was successfully destroyed.'}
      format.json {head :no_content}
    end
  end

  private

  def verify_owner
    # Create ProjectCustomer
    if @project_customer.nil?
      project = Project.find(params[:project_id])
    else
      # Edit, Update, Destroy
      project = @project_customer.project
    end

    unless project.has_owner(current_user)
      flash[:error] = "You must be the owner to modify project or add / update / delete project customer(s)"
      redirect_to projects_url # halts request cycle
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project_customer
    @project_customer = ProjectCustomer.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_customer_params
    params.require(:project_customer).permit(:project_id, :user_id)
  end
end
