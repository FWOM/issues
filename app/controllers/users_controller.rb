class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, only: [:index, :show, :edit, :update, :destroy]
  before_filter :correct_user_admin , only: [:index, :destroy]
  before_filter :correct_user , only: [:show, :edit, :update]


  # GET /users
  # GET /users.json
  def index
    @title = 'Usuarios'
    @users = User.paginate(:page => params[:page],:per_page => 5)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @title= @user.name
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(:page => params[:page], :per_page => 5)
  end

  # GET /users/new
  def new
    @user = User.new
    @title = 'Sign up'
  end

  # GET /users/1/edit
  def edit
    @title = 'Edit '+@user.name
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        sign_in(@user)
        format.html { redirect_to @user, notice: "#{@user.name} account was successfully created." }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_path, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def authenticate
      denny_access unless sign_in?
    end

  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user) || current_user.admin?
        redirect_to(root_path)
    end
  end

  def correct_user_admin
    if sign_in?
      unless current_email?("fwom@hotmail.com") || current_user.admin?
        redirect_to(root_path, notice: "You can't complete this action.")
      end
    else
      redirect_to(root_path, notice: "You can't complete this action.")
    end
  end

    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name,
                                   :email,
                                   :password,
                                   :password_confirmation,
                                   :admin, :encrypted_password,
                                   :salt,
                                   :parent,
                                   :description,
                                   :image,
                                   :phone,
                                   :template_name,
                                   :href,
                                   :color)
    end
end
