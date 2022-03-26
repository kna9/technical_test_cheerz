# initialize pseudos

Pseudo.destroy_all

# populate pseudos

alphabet = ('A'..'Z').to_a
item_number = 0

alphabet.each do |c1|
  alphabet.each do |c2|
    alphabet.each do |c3|
      pseudo = "#{c1}#{c2}#{c3}"
      Pseudo.create!({ pseudo: pseudo })

      item_number += 1
      puts("User #{pseudo} created (#{item_number} / #{26**3})")
    end 
  end 
end
