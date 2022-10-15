namespace :remind do
  desc "明日期限のタスクが未済であるユーザーにリマインドします。"
  task notice: :environment do
    puts "\n== 明日期限のタスクが未済のユーザーにリマインドをします。 =="

    reservations_today = NotificationReservation.where(reservation_date: Date.today)

    if reservations_today.blank?
      abort "\n== 明日期限のタスクはありませんでした。 =="
    end

    users = User.all

    reservations_today.each do |reservation|
      task = reservation.task
      notify_users = users.select {|user| !user.done?(task)}

      if notify_users.empty?
        abort "\n== 全員が完了していたため、リマインドを行いませんでした。 =="
      end

      notifier = Slack::Notifier.new(
        Rails.application.credentials.slack.webhook_url,
        channel: "timeline-handa"
      )

      notifier.post(
        text: "『#{task.description}』の期限が明日に迫っています！対応よろしくお願いします。",
        at: notify_users.pluck(:slack_member_id)
      )

      puts "\n== リマインドが完了しました。 =="
    end
  end
end
