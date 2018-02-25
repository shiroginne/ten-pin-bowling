FactoryBot.define do
  factory :game do
    title "Game of Thrones"

    factory :game_with_players do
      after :build do |game, evaluator|
        game.players.build(attributes_for :player)
      end
    end
  end
end
