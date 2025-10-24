class AddStudentNoToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :student_no, :string
  end
end
