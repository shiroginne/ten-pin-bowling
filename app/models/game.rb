class Game < ApplicationRecord
  has_many :players
  accepts_nested_attributes_for :players

  validates :title, length: { minimum: 3 }
  validates :players, presence: true
end
