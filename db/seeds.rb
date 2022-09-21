# 適当に100件作る
100.times do |n|
  Task.create!(
    description: "#{n}の対応のお願いです。何か疑問点がありましたら管理部まで質問してください。",
    created_at: Time.current + n.days,
    due_on: Time.zone.today + n.days
  )
end
