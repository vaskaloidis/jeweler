class ProjectCustomersController < ApplicationController
  before_action :set_project_customer,
                only: [:verify_owner, :show, :edit, :update, :destroy]
  before_action :verify_owner,
                only: [:create, :edit, :update, :destroy]

  def create_customer_inline
    invite_feature = false

    email = params[:email]
    project = Project.find(params[:project_id])


    @save = project.invitations.create(email: email)

    if invite_feature
      # if User.where(email: email).empty?
      # else
      user = User.where(email: email).first

      logger.debug("Adding Customer to Project ID: " + project.id.to_s + ". Customer ID: " + user.id.to_s + " / EMAIL: " + email)

      pc = ProjectCustomer.new
      pc.project = project
      pc.user = user
      pc.save
      @save = pc
    end

    project.invitations.reload
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
    @project_customers = ProjectCustomer.all
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
