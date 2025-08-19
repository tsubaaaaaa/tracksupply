class AddTokenToIndividuals < ActiveRecord::Migration[7.1]
  def change
    add_column :individuals, :token, :string
    add_index :individuals, :token, unique: true
  end
end
