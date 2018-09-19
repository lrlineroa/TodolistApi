class ListsController < ApplicationController
  before_action :authenticate_user
  before_action :set_user
  before_action :set_list, only: [:show, :update, :destroy]
  
  # GET /lists
  def index
    @lists =@user.lists.all 
    

    render json: @lists
  end

  # GET /lists/1
  def show
    render json: @list
  end

  # POST /lists
  def create
    @list = @user.lists().create(list_params)
    @user.users_lists().where("list_id = ?",@list.id).first.update({is_owner: 1,
      visible: 1,
      can_edit:1
    })
    if @list.valid?
     render json: @list, status: :created
    else
     render json: @list.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /lists/1
  def update
    if @list.update(list_params)
      render json: @list
    else
      render json: @list.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lists/1
  def destroy
    @user.lists.destroy(@list)
    @list.destroy()
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_list
      @list = @user.lists.find(params[:id])
    end
    def set_user
      @user=User.find(params[:user_id])
    end

    # Only allow a trusted parameter "white list" through.
    def list_params
      params.require(:list).permit(:name)
    end
end
