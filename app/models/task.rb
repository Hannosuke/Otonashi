class Task < ApplicationRecord
  validates :description, presence: true, length: { maximum: 4000 }
  validates :due_on, presence: true

  has_many :completions, dependent: :destroy
  has_one :notification_reservation, dependent: :destroy
  belongs_to :user

  def reserve_notification
    create_notification_reservation!(reservation_date: due_on - 1.day)
  end

  def inform
    if save
      begin
        reserve_notification

        notifier = Slack::Notifier.new(
          Rails.application.credentials.slack.webhook_url,
          channel: 'timeline-handa'
        )

        text = <<~EOS
          #{description}

          <a href="#{Settings.base_url}/tasks/#{id}">Otonashi で見る</a> 💁🏼‍♀️
        EOS

        notifier.ping(text)
      rescue => e
        # NOTE: 実際に運用する際にはエラートラッキングツール等へ送る
      end

      true
    else
      false
    end
  end
end
