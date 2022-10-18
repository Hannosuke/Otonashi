class TasksController < ApplicationController
  before_action :set_current_users_task, only: %i(edit update destroy)

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

    if @task.inform
      flash.now.notice = "タスクを保存しました。"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @task = Task.find(params[:id])
    @users = User.all
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash.now.notice = "タスクを更新しました。"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    flash.now.notice = "タスクを削除しました。"
  end

  private

  def set_current_users_task
    @task = current_user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description, :due_on)
  end
end
