class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.integer :birthdate

      t.timestamps
    end
  end
end
