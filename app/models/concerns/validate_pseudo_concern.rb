module ValidatePseudoConcern
  extend ActiveSupport::Concern
  
  included do
    validates :pseudo, presence: true, format: { with: /\A[A-Z]{3}\z/, message: 'must be 3 letters, uppercase, without special characters, without numbers'}
  end
end
