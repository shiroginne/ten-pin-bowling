class Player < ApplicationRecord
  belongs_to :game, inverse_of: :players, optional: true

  validates :name, length: { minimum: 3 }
end
