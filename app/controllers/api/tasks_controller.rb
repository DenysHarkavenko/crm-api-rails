class Api::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_project
  before_action :set_task, only: [:show, :update, :destroy]

  def index
    cache_key = "tasks/#{params[:project_id]}/all_tasks"
    @tasks = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      tasks = @project.tasks
      # direction=asc - In progress -> Pending / direction=desc - Pending -> In progress
      if params[:sort].present? && %w[asc desc].include?(params[:direction].to_s.downcase)
        tasks = tasks.order(status: params[:direction].to_sym)
      end
      tasks
    end

    render json: @tasks
  end

  def show
    render json: @task
  end

  def create
    @task = @project.tasks.build(task_params)

    if @task.save
      render json: @task, status: :created
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def update
    if @task.update(task_params)
      render json: @task
    else
      render json: @task.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    head :no_content
  end

  private

  def set_project
    @project = Project.find(params[:project_id])
  end

  def set_task
    @task = @project.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:name, :description, :status)
  end
end
