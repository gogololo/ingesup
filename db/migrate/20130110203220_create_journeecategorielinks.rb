class CreateJourneecategorielinks < ActiveRecord::Migration
  def change
    create_table :journeecategorielinks do |t|
      t.integer :journee_id
      t.integer :categorie_id

      t.timestamps
    end
  end
end
