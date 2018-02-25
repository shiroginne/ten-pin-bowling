class Player < ApplicationRecord
  belongs_to :game, inverse_of: :players, optional: true
  has_many :frames, dependent: :destroy
  validates :name, length: { minimum: 3 }
end
