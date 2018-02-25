class Game < ApplicationRecord
  has_many :players
  has_many :frames, dependent: :destroy

  accepts_nested_attributes_for :players

  validates :title, length: { minimum: 3 }
  validates :players, presence: true

  after_create :setup_game

  private
    def setup_game
      players.each { |p| frames.create(player: p) }
    end
end
