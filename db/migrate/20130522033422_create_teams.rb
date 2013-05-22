class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.references :player

      t.timestamps
    end
    add_index :teams, :player_id
  end
end
