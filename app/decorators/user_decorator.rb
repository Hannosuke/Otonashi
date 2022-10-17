module UserDecorator
  def task_status(task)
    completions.where(task: task).exists? ? "Done"  : "Not yet"
  end
end
