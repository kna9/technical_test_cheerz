class AddIndexToPseudos < ActiveRecord::Migration[6.1]
  def change
    add_index :pseudos, :pseudo, unique: true
  end
end
