class CreateLessons < ActiveRecord::Migration[7.2]
  def change
    create_table :lessons do |t|
      t.references :user, null: false, foreign_key: true
      t.string :subject
      t.integer :period_number
      t.date :date
      t.integer :is_attendance
      t.string :absence_reason

      t.timestamps
    end
  end
end
