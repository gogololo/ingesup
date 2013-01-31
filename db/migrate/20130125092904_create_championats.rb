class CreateChampionats < ActiveRecord::Migration
  def change
    create_table :championats do |t|
      t.string :name

      t.timestamps
    end
  end
end
