puts "\n== seedを実行しています =="

user_attributes = {
  name: Rails.application.credentials.test_user.name,
  email: Rails.application.credentials.test_user.email,
  password: Rails.application.credentials.test_user.password,
  slack_member_id: Rails.application.credentials.test_user.slack_member_id,
  admin: true
}
user = User.where(email: Rails.application.credentials.email).first_or_create!(user_attributes)

puts "\n== seedの実行が完了しました =="
