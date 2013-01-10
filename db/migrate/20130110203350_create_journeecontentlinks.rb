class CreateJourneecontentlinks < ActiveRecord::Migration
  def change
    create_table :journeecontentlinks do |t|
      t.integer :journee_id
      t.integer :content_id

      t.timestamps
    end
  end
end
