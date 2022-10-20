namespace :sample_user do
  desc "動作確認用のサンプルユーザーデータを作成します。"
  task create: :environment do
    puts "\n== 動作確認用ユーザーデータを作成しています。 =="

    # 従業員数を鑑みて適当に20人
    20.times do |n|
      User.create!(
        name: Faker::Name.name,
        email: Faker::Internet.email,
        password: Rails.application.credentials.test_user.password,
        password_confirmation: Rails.application.credentials.test_user.password,
        slack_member_id: Rails.application.credentials.test_user.slack_member_id
      )
    end

    puts "\n== 動作確認用ユーザーデータを作成しました。 =="
  end
end
