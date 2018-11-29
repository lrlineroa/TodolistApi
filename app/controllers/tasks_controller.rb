class TasksController < ApplicationController
  before_action :authenticate_user
  before_action :set_list
  before_action :set_task, only: [:show, :update, :destroy]

  # GET /tasks
  def index
    @tasks = @list.tasks.all

    render json: @tasks
  end

  # GET /tasks/1
  def show
    render json: @task
  end

  # POST /tasks
  def create
    @task = @list.tasks().create(task_params)

    if @task.valid?
      render json: @task, status: :created, location: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tasks/1
  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tasks/1
  def destroy
    @task.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = @list.tasks.find(params[:id])
    end

    def set_list
      @list=List.find(params[:list_id])
    end

    # Only allow a trusted parameter "white list" through.
    def task_params
      params.require(:task).permit(:name, :list)
    end
end
