class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :name
      t.text :aliases
      t.references :team

      t.timestamps
    end
    add_index :players, :team_id
  end
end
