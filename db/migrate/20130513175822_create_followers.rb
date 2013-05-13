class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |t|
      t.integer :guid

      t.timestamps
    end
  end
end
