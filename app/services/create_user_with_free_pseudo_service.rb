class CreateUserWithFreePseudoService
  attr_reader :user

  def initialize(user)
    @user = user
  end 

  def perform
    return { success: false, errors: parse_errors(user.errors) } unless user.valid?

    error = nil

    begin
      user.save!
    rescue ActiveRecord::RecordNotUnique => e
      next_free_pseudo = Pseudo.first_free

      if next_free_pseudo.empty?
        error = "pseudo is not availlable"
        raise
      end

      user.pseudo = next_free_pseudo.first.pseudo
      retry
    rescue => e
      error =  e.message
    ensure
      return error ? { success: false, errors: [error] } : { success: true, pseudo: user.pseudo }
    end

    # TODO : here : if database scales and database option is no longer efficient
    # change this block in rescue to use dichotomy algorythm to choose new pseudo
    # but it can make more attemps when the user database is full

    # TODO : manage when user are empty (all pseudo are used) : probably integrate in the exception loop
  end

  private

  def parse_errors(errors)
    errors.map do |error|
      "#{error.attribute} #{error.type.to_s} #{error.options[:message].to_s}".strip
    end
  end
end