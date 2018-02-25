class AddStateToFrame < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :state, :integer, default: 0
  end
end
