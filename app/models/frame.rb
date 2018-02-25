class Frame < ApplicationRecord
  belongs_to :game, inverse_of: :frames
  belongs_to :player
  has_many :turns, dependent: :destroy
end
