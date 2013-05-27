class AddTeamNameToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :team_name, :string
  end
end
