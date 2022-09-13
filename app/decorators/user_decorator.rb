module UserDecorator
  def task_status(task)
    completions.where(task: task).exists? ? "DONE"  : "NOT YET"
  end
end
