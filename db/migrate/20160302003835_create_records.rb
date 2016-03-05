class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.date :date
      t.float :stay
      t.float :consumption

      t.timestamps null: false
    end

    add_index :records, :date, unique: true
  end
end
