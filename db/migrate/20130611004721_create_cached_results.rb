class CreateCachedResults < ActiveRecord::Migration
  def change
    create_table :cached_results do |t|
      t.string :name
      t.text :result

      t.timestamps
    end
  end
end
