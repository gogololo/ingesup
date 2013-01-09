class CreateResultatcategorielinks < ActiveRecord::Migration
  def change
    create_table :resultatcategorielinks do |t|
      t.integer :resultat_id
      t.integer :categorie_id

      t.timestamps
    end
  end
end
