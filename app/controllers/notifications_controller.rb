class NotificationsController < ApplicationController
  SLACK_WEBHOOK_URL = Rails.application.credentials.slack.webhook_url
  SLACK_CHANNEL = 'timeline-handa'

  def create
    task = Task.find(params[:task_id])

    notifier = Slack::Notifier.new(
      SLACK_WEBHOOK_URL,
      channel: SLACK_CHANNEL
    )

    notifier.ping("『#{task.description}』の締切が迫っています！対応よろしくお願いします。")

    redirect_to task_path(task), notice: "リマインドが完了しました。"
  end
end
