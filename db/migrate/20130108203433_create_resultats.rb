class CreateResultats < ActiveRecord::Migration
  def change
    create_table :resultats do |t|
      t.string :rang
      t.string :team
      t.integer :points
      t.integer :journee
      t.integer :gagne
      t.integer :nuls
      t.integer :butplus
      t.integer :butmoins
      t.integer :diff

      t.timestamps
    end
  end
end
