class CreateContents < ActiveRecord::Migration
  def change
    create_table :contents do |t|
      t.string :date
      t.string :team1
      t.integer :team1core
      t.string :team2
      t.integer :team2score
      t.string :fdm

      t.timestamps
    end
  end
end
