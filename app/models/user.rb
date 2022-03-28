class User < ApplicationRecord
  include ValidatePseudoConcern

  validate :validate_pseudo_exists

  UPPERCASE_ALPHABET_START_INDEX = 65
  ALPHABET_SIZE = 26

  # random valid pseudo is generated if no expected_pseudo
  def self.create_with_free_pseudo(expected_pseudo = (0...3).map { (UPPERCASE_ALPHABET_START_INDEX + rand(ALPHABET_SIZE)).chr }.join)
    CreateUserWithFreePseudoService.new(self.new(pseudo: expected_pseudo)).perform
  end

  private

  def validate_pseudo_exists
    errors.add(:pseudo, 'does not exist') if Pseudo.find_by_pseudo(self.pseudo).nil?
  end
end
