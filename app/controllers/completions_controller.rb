class CompletionsController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    current_user.complete(task)

    redirect_to tasks_path
  end
end
