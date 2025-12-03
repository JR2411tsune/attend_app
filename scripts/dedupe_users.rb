# 実行: (dry-run) bin/rails runner scripts/dedupe_users.rb
# 実行: (本実行) EXECUTE=1 bin/rails runner scripts/dedupe_users.rb

dup_student_nos = User.where.not(student_no: nil)
                      .group(:student_no)
                      .having('COUNT(*) > 1')
                      .pluck(:student_no)

if dup_student_nos.empty?
  puts "重複する student_no はありません。"
  exit 0
end

dup_student_nos.each do |sno|
  users = User.where(student_no: sno).order(:id).to_a
  keeper = users.first
  dupes = users[1..-1] || []

  puts "student_no=#{sno} を統合 -> keeper id=#{keeper.id}, name=#{keeper.name}"
  dupes.each do |d|
    puts "  duplicate id=#{d.id}, name=#{d.name} (will be merged into #{keeper.id})"
  end

  next unless ENV['EXECUTE'] == '1' || ENV['EXECUTE'] == 'true'

  # lessons を代表ユーザーに移す
  dup_ids = dupes.map(&:id)
  if dup_ids.any?
    Lesson.where(user_id: dup_ids).update_all(user_id: keeper.id)
    User.where(id: dup_ids).destroy_all
    puts "  merged lessons from #{dup_ids.join(',')} -> user #{keeper.id} and deleted duplicates"
  else
    puts "  移動対象なし"
  end
end
