class CreateJournees < ActiveRecord::Migration
  def change
    create_table :journees do |t|
      t.string :title

      t.timestamps
    end
  end
end
