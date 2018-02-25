FactoryBot.define do
  factory :frame do
    association :game, factory: :game_with_players
    association :player
  end
end
