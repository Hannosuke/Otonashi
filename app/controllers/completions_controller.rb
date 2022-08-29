class CompletionsController < ApplicationController
  def create
    task = Task.find(params[:task_id])
    current_user.complete(task)

    redirect_to tasks_path
  end

  def destroy
    completion = Completion.find_by(user: current_user, task_id: params[:task_id])
    completion.destroy

    redirect_to tasks_path
  end
end
