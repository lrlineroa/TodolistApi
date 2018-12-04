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

  def configShares
    ownerId=params["user_id"]
    listId=params["list_id"]
    guestId=params["guest_id"]
    typeGrant=params["type"]
    value=params["value"].to_i
    #buscamos primero el usuario propietario
    user=User.find(ownerId);
    #buscamos el registro en la tabla auxiliar
    record= user.users_lists().where("list_id= ? and is_owner= ?",listId,true).first
    if record != nil
      guest=User.find(guestId);
      #vamos a buscar si el owner ya le ha compartido antes la lista
      record= guest.users_lists().where("list_id= ? ",listId).first
      #si hay una asociaci'on la actualizamos si no la creamos
      unless record != nil
        list=List.find(listId)
        record=UsersList.create(list: list, user: guest)
      end
      if typeGrant=="visible"
        record.update({
          visible: value
        })
        #si no se puede ver por lo tanto tampoco se puede editar
        #entonces se elimina el registro
        logger.debug 'el valor es ' +value
        if !value
          logger.debug 'entrooooooooo y se va a eliminar el registro'
          record.destroy()
          render json: record, status: :ok
        end
      elsif typeGrant=="can_edit"
        record.update({
            can_edit: value
          })
        #si puede editar por consiguiente tambien puede ver
        if value
          record.update({
            visible: 1
          })
        end
      end 
      render json: record, status: :ok
    else
      render json: {status: "UNSUCCES", message: "no hay listas para el propietario" },status: :not_found
    end
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
