class CreateCategoriesChampionats < ActiveRecord::Migration
  def change
    create_table :categories_championats do |t|
      t.integer :championat_id
      t.integer :categorie_id

      t.timestamps
    end
  end
end
