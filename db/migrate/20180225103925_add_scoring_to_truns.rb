class AddScoringToTruns < ActiveRecord::Migration[5.2]
  def change
    add_column :turns, :scoring, :integer, default: 0
  end
end
