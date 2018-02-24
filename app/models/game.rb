class Game < ApplicationRecord
  validates :title, length: { minimum: 3 }
end
