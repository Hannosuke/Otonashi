class ChangeColumnsNotnullOnCompletions < ActiveRecord::Migration[7.0]
  def change
    change_column_null :completions, :user_id, false
    change_column_null :completions, :task_id, false
  end
end
