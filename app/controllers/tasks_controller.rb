class TasksController < ApplicationController
  before_filter :authorize, only: [:edit, :new, :destroy, :index]
  skip_before_action :verify_authenticity_token

  def index
    order_by  = params[:order_by] || 'priority'
    direction = params[:direction] || 'asc'
    @order = "#{order_by} #{direction}"
    tasks = current_user.tasks.order(@order)
    tasks = tasks.send(params[:status]) if params[:status]
    render json: tasks
  end

  def create
    render json: current_user.tasks.create(task_params)
  end

  def update
    @task = current_user.tasks.find(params[:id])
    @task.update(task_params)
    render json: @task
  end

  def destroy
    @task = current_user.tasks.find(params[:id])
    render json: @task.destroy
  end

  private

  def task_params
    params.require(:task).permit(:id, :title, :due_date, :priority, :completed)
  end

end
