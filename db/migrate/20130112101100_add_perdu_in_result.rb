class AddPerduInResult < ActiveRecord::Migration
	def change
		add_column :resultats, :perdu, :string
	end
end