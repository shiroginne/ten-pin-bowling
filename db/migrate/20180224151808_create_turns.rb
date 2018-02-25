class CreateTurns < ActiveRecord::Migration[5.2]
  def change
    create_table :turns do |t|
      t.integer :pins_count
      t.integer :status
      t.references :frame
      t.timestamps
    end
  end
end
