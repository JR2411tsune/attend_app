require 'date'
require 'csv'

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

# ランダムな6桁の数字文字列を生成するヘルパーメソッド
def generate_random_password
  # 100000 から 999999 の間のランダムな整数を文字列として返す
  rand(100000..999999).to_s
end

# ランダムな名字と名前の組み合わせの配列
LAST_NAMES = ["佐藤", "鈴木", "高橋", "田中", "伊藤", "渡辺", "山本", "中村", "小林", "加藤", "吉田", "山田", "佐々木", "山口", "松本", "井上", "木村", "林", "斎藤", "清水"]
FIRST_NAMES = ["陽太", "蓮", "湊", "悠真", "朝陽", "律", "樹", "大翔", "蒼", "結翔", "葵", "凛", "結菜", "莉子", "陽菜", "芽依", "咲良", "紬", "結月", "心春"]

# ランダムな氏名を生成するヘルパーメソッド
def generate_random_name
  last_name = LAST_NAMES.sample
  first_name = FIRST_NAMES.sample
  "#{last_name} #{first_name}"
end

userdata_list = []

# JR9902からJR9930までループ
(1..30).each do |i|
  # student_noを "JR9902" から "JR9930" の形式で作成
  student_number = "JR99#{format('%02d', i)}"
  
  # ランダムなパスワードと名前を生成
  random_password = generate_random_password
  random_name = generate_random_name
  
  # Userを作成または見つける
  User.find_or_create_by!(student_no: student_number) do |u|
    u.password = random_password # ランダムな6桁のパスワード
    u.name = random_name         # ランダムな氏名
    u.role = "student"           # 固定値
    u.attendance_count = 0       # 固定値
    u.absence_count = 0          # 固定値
  end

  userdata_list << [student_number, random_password, random_name]
end

# CSVファイル出力
CSV_FILE_PATH = Rails.root.join("userdata_list.csv")

CSV.open(CSV_FILE_PATH, "wb") do |csv|
  csv << ["student_no", "password", "name"]

  userdata_list.each do |userdata|
    csv << userdata
  end
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

# 11/17(月)
lessons << {subject: "Ruby2Java2", period_number: 1, date: Date.new(2025, 11, 17)}
lessons << {subject: "Webデザイン4", period_number: 2, date: Date.new(2025, 11, 17)}
lessons << {subject: "国家試験対策4", period_number: 3, date: Date.new(2025, 11, 17)}

# 11/18(火)
lessons << {subject: "Webデザイン4", period_number: 1, date: Date.new(2025, 11, 18)}
lessons << {subject: "卒業研究1", period_number: 2, date: Date.new(2025, 11, 18)}
lessons << {subject: "卒業研究1", period_number: 3, date: Date.new(2025, 11, 18)}

# 11/19(水)
lessons << {subject: "実践ボランティア2", period_number: 1, date: Date.new(2025, 11, 19)}
lessons << {subject: "国家試験対策4", period_number: 2, date: Date.new(2025, 11, 19)}
lessons << {subject: "Webデザイン4", period_number: 3, date: Date.new(2025, 11, 19)}

# 11/20(木)
lessons << {subject: "総合実践4", period_number: 1, date: Date.new(2025, 11, 20)}
lessons << {subject: "総合実践4", period_number: 2, date: Date.new(2025, 11, 20)}
lessons << {subject: "JSP1", period_number: 3, date: Date.new(2025, 11, 20)}

# 11/21(金)
lessons << {subject: "Rails2Android2", period_number: 1, date: Date.new(2025, 11, 21)}
lessons << {subject: "Rails2Android2", period_number: 2, date: Date.new(2025, 11, 21)}

# 11/24(月)
# 休日

# 11/25(火)
lessons << {subject: "Ruby2Java2", period_number: 1, date: Date.new(2025, 11, 25)}
lessons << {subject: "国家試験対策4", period_number: 2, date: Date.new(2025, 11, 25)}
lessons << {subject: "Webデザイン4", period_number: 3, date: Date.new(2025, 11, 25)}

# 11/26(水)
lessons << {subject: "卒業研究1", period_number: 1, date: Date.new(2025, 11, 26)}
lessons << {subject: "卒業研究1", period_number: 2, date: Date.new(2025, 11, 26)}
lessons << {subject: "JSP1", period_number: 3, date: Date.new(2025, 11, 26)}

# 11/27(木)
lessons << {subject: "JSP1", period_number: 1, date: Date.new(2025, 11, 27)}
lessons << {subject: "総合実践4", period_number: 2, date: Date.new(2025, 11, 27)}
lessons << {subject: "総合実践4", period_number: 3, date: Date.new(2025, 11, 27)}

# 11/28(金)
lessons << {subject: "Rails2Android2", period_number: 1, date: Date.new(2025, 11, 28)}
lessons << {subject: "Rails2Android2", period_number: 2, date: Date.new(2025, 11, 28)}

# 12/1(月)
lessons << {subject: "Ruby2Java2", period_number: 1, date: Date.new(2025, 12, 1)}
lessons << {subject: "JSP1", period_number: 2, date: Date.new(2025, 12, 1)}
lessons << {subject: "国家試験対策4", period_number: 3, date: Date.new(2025, 12, 1)}

# 12/2(火)
lessons << {subject: "Ruby2Java2", period_number: 1, date: Date.new(2025, 12, 2)}
lessons << {subject: "JSP1", period_number: 2, date: Date.new(2025, 12, 2)}
lessons << {subject: "Webデザイン4", period_number: 3, date: Date.new(2025, 12, 2)}

# 12/3(水)
lessons << {subject: "Rails2Android2", period_number: 1, date: Date.new(2025, 12, 3)}
lessons << {subject: "Rails2Android2", period_number: 2, date: Date.new(2025, 12, 3)}
lessons << {subject: "Rails2Android2", period_number: 3, date: Date.new(2025, 12, 3)}

# 12/4(木)
lessons << {subject: "卒業研究1", period_number: 1, date: Date.new(2025, 12, 4)}
lessons << {subject: "卒業研究1", period_number: 2, date: Date.new(2025, 12, 4)}
lessons << {subject: "総合実践4", period_number: 3, date: Date.new(2025, 12, 4)}

# 12/5(金)
lessons << {subject: "Rails2Android2", period_number: 1, date: Date.new(2025, 12, 5)}
lessons << {subject: "Rails2Android2", period_number: 2, date: Date.new(2025, 12, 5)}

# 12/8(月)
lessons << {subject: "国家試験対策1", period_number: 1, date: Date.new(2025, 12, 8)}
lessons << {subject: "国家試験対策1", period_number: 2, date: Date.new(2025, 12, 8)}
lessons << {subject: "卒業研究1", period_number: 3, date: Date.new(2025, 12, 8)}

# 12/9(火)
lessons << {subject: "Ruby2Java2", period_number: 1, date: Date.new(2025, 12, 9)}
lessons << {subject: "JSP1", period_number: 2, date: Date.new(2025, 12, 9)}
lessons << {subject: "Webデザイン4", period_number: 3, date: Date.new(2025, 12, 9)}

# 12/10(水)
lessons << {subject: "Webデザイン4", period_number: 1, date: Date.new(2025, 12, 10)}
lessons << {subject: "卒業研究1", period_number: 2, date: Date.new(2025, 12, 10)}
lessons << {subject: "卒業研究1", period_number: 3, date: Date.new(2025, 12, 10)}

# 12/11(木)
lessons << {subject: "総合実践4", period_number: 1, date: Date.new(2025, 12, 11)}
lessons << {subject: "総合実践4", period_number: 2, date: Date.new(2025, 12, 11)}
lessons << {subject: "JSP1", period_number: 3, date: Date.new(2025, 12, 11)}

# 12/12(金)
lessons << {subject: "Rails2Android2", period_number: 1, date: Date.new(2025, 12, 12)}
lessons << {subject: "Rails2Android2", period_number: 2, date: Date.new(2025, 12, 12)}

# 12/15(月)
lessons << {subject: "Webデザイン4", period_number: 1, date: Date.new(2025, 12, 15)}
lessons << {subject: "JSP1", period_number: 2, date: Date.new(2025, 12, 15)}
lessons << {subject: "企業講演会2", period_number: 3, date: Date.new(2025, 12, 15)}

# 12/16(火)
lessons << {subject: "総合実践4", period_number: 1, date: Date.new(2025, 12, 16)}
lessons << {subject: "卒業研究1", period_number: 2, date: Date.new(2025, 12, 16)}
lessons << {subject: "卒業研究1", period_number: 3, date: Date.new(2025, 12, 16)}

# 12/17(水)
lessons << {subject: "総合実践4", period_number: 1, date: Date.new(2025, 12, 17)}
lessons << {subject: "JSP1", period_number: 2, date: Date.new(2025, 12, 17)}
lessons << {subject: "卒業研究1", period_number: 3, date: Date.new(2025, 12, 17)}

# 12/18(木)
lessons << {subject: "総合実践4", period_number: 1, date: Date.new(2025, 12, 18)}
lessons << {subject: "総合実践4", period_number: 2, date: Date.new(2025, 12, 18)}
lessons << {subject: "キャリア演習2", period_number: 3, date: Date.new(2025, 12, 18)}

# 12/19(金)
lessons << {subject: "Rails2Android2", period_number: 1, date: Date.new(2025, 12, 19)}
lessons << {subject: "Rails2Android2", period_number: 2, date: Date.new(2025, 12, 19)}

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
