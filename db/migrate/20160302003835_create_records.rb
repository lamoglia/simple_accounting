class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.date :date
      t.float :stay
      t.float :consumption

      t.timestamps null: false
    end
  end
end
