class CreateTestsumples < ActiveRecord::Migration[7.2]
  def change
    create_table :testsumples do |t|
      t.string :status

      t.timestamps
    end
  end
end
