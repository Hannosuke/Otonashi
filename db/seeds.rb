puts "\n== seedを実行しています =="

user_attributes = {
  name: Rails.application.credentials.test_user.name,
  email: Rails.application.credentials.test_user.email,
  password: Rails.application.credentials.test_user.password,
  slack_member_id: Rails.application.credentials.test_user.slack_member_id,
  admin: true
}
user = User.where(email: Rails.application.credentials.email).first_or_create!(
  user_attributes
)

# 適当に100件作る
100.times do |n|
  user.tasks.create!(
    description: "#{n}の対応のお願いです。何か疑問点がありましたら管理部まで質問してください。",
    created_at: Time.current + n.days,
    due_on: Time.zone.today + n.days
  )
end

puts "\n== seedの実行が完了しました =="
