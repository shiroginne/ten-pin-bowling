class CreateFrames < ActiveRecord::Migration[5.2]
  def change
    create_table :frames do |t|
      t.references :game
      t.references :player
      t.timestamps
    end
  end
end
