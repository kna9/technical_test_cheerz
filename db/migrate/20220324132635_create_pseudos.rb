class CreatePseudos < ActiveRecord::Migration[6.1]
  def change
    create_table :pseudos do |t|
      t.string :pseudo
    end
  end
end
