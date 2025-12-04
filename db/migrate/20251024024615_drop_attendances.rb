class DropAttendances < ActiveRecord::Migration[7.2]
  def change
    drop_table :attendances
  end
end
