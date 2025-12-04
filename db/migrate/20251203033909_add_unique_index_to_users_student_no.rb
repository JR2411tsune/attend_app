class AddUniqueIndexToUsersStudentNo < ActiveRecord::Migration[7.2]
  def change
    add_index :users, :student_no, unique: true
  end
end
