class AddStateToGame < ActiveRecord::Migration[5.2]
  def change
    add_column :games, :state, :integer, default: 0
  end
end
