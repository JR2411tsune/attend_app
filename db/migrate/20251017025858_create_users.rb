class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :password_digest
      t.string :role
      t.integer :attendance_count
      t.integer :absence_count

      t.timestamps
    end
  end
end
