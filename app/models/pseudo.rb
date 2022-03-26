class Pseudo < ApplicationRecord
  include ValidatePseudoConcern

  scope :first_free, -> { joins('LEFT JOIN users on pseudos.pseudo = users.pseudo').where(users: { pseudo: nil }).limit(1) }
end