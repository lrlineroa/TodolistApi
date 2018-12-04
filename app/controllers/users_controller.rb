class UsersController < ApplicationController
  before_action :authenticate_user, except: [:create]
  before_action :set_user, only: [:show, :update, :destroy]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  def getUsersForSharingList
    sharingListId=params["list_id"]
    @users = User.includes(:users_lists)
    @users.each do |user|
      user.users_lists.each do |ul|
        logger.debug ul.visible
        ul.visible
      end
      
    #   class << user
    #     attr_accessor :canEdit
    #     attr_accessor :canView
    #   end
      
    #   record=user.users_lists().where("list_id = ?",sharingListId).first
      
    #   if record==nil
    #     user.canEdit = false;
    #     user.canView = false;
    #   else
    #     user.canEdit =record.visible;
    #     user.canView =record.can_edit;
    #   end
    end
    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    @user = User.new(user_params)
    
    if @user.save
      render json: @user, status: :created
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.permit(:name, :email,:role_id , :username, :password, :password_confirmation)
    end
end
