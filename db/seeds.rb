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
# 10/27(月)
