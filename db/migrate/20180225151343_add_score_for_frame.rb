class AddScoreForFrame < ActiveRecord::Migration[5.2]
  def change
    add_column :frames, :score, :integer, default: 0
  end
end
