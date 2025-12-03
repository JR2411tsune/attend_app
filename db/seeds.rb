require 'date'

# 管理者・生徒を student_no で idempotent に作成/更新
User.find_or_create_by!(student_no: "JR9999") do |u|
  u.password = "999999"
  u.name = "渡辺 秀城"
  u.role = "administrator"
  u.attendance_count = 0
  u.absence_count = 0
end

User.find_or_create_by!(student_no: "JR9901") do |u|
  u.password = "123456"
  u.name = "山田 太郎"
  u.role = "student"
  u.attendance_count = 0
  u.absence_count = 0
end

# レッスン定義（変更なし）
lessons = []

# 11/10(月)
lessons << {subject: "実践ボランティア2", period_number: 1, date: Date.new(2025, 11, 10)}
lessons << {subject: "Ruby2Java2", period_number: 2, date: Date.new(2025, 11, 10)}
lessons << {subject: "国家試験対策4", period_number: 3, date: Date.new(2025, 11, 10)}

# 11/11(火)
lessons << {subject: "Webデザイン4", period_number: 1, date: Date.new(2025, 11, 11)}
lessons << {subject: "Ruby2Java2", period_number: 2, date: Date.new(2025, 11, 11)}
lessons << {subject: "Webデザイン4", period_number: 3, date: Date.new(2025, 11, 11)}

# 11/12(水)
lessons << {subject: "実践ボランティア2", period_number: 1, date: Date.new(2025, 11, 12)}
lessons << {subject: "実践ボランティア2", period_number: 2, date: Date.new(2025, 11, 12)}
lessons << {subject: "実践ボランティア2", period_number: 3, date: Date.new(2025, 11, 12)}

# 11/13(木)
lessons << {subject: "総合実践4", period_number: 1, date: Date.new(2025, 11, 13)}
lessons << {subject: "総合実践4", period_number: 2, date: Date.new(2025, 11, 13)}
lessons << {subject: "総合実践4", period_number: 3, date: Date.new(2025, 11, 13)}

# 11/14(金)
lessons << {subject: "Rails2Android2", period_number: 1, date: Date.new(2025, 11, 14)}
lessons << {subject: "Rails2Android2", period_number: 2, date: Date.new(2025, 11, 14)}

# student_no ごとに代表ユーザーだけにレッスンを作る（重複がある場合の防止）
representative_students = User.where(role: "student").group_by(&:student_no).transform_values(&:first).values

representative_students.each do |student|
  lessons.each do |lesson|
    Lesson.find_or_create_by!(
      user_id: student.id,
      subject: lesson[:subject],
      period_number: lesson[:period_number],
      date: lesson[:date]
    ) do |l|
      l.is_attendance = 0
      l.absence_reason = ""
    end
  end
end
