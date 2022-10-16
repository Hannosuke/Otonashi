class TasksController < ApplicationController
  before_action :set_task, only: %i(show destroy)

  def index
    @search = Task.ransack(params[:q])
    @search.sorts = 'created_at desc' if @search.sorts.empty?

    @tasks = @search.result.page(params[:page])
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.new(task_params)

    if @task.save
      @task.reserve_notification
      flash.now.notice = "タスクを保存しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @users = User.all
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])

    if @task.update(task_params)
      flash.now.notice = "タスクを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :due_on)
  end
end
