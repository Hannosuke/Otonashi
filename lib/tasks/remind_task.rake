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

      text = <<~EOS
        期限が明日に迫っているタスクがあります、ご対応よろしくお願いします！！

        『#{task.description}』

        <a href="#{Settings.base_url}/tasks/#{task.id}">Otonashi で見る</a> 💁🏼‍♀️
      EOS

      notifier.post(
        text: text,
        at: notify_users.pluck(:slack_member_id)
      )

    end

    puts "\n== リマインドが完了しました。 =="
  end
end
