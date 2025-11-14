require 'date'

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# users
# students
User.create!(student_no: "JR9901", password: "123456", name: "山田 太郎", role: "student", attendance_count: 0, absence_count: 0)
# administrators
User.create!(student_no: "JR9999", password: "999999", name: "渡辺 秀城", role: "administrator", attendance_count: 0, absence_count: 0)

# lessons
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

# 作成
User.where(role: "student").each do |student|
  lessons.each do |lesson|
    Lesson.find_or_create_by(
      user: student,
      subject: lesson[:subject],
      period_number: lesson[:period_number],
      date: lesson[:date],
      is_attendance: 0,
      absence_reason: ""
    )
  end
end