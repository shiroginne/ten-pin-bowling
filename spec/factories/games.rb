FactoryBot.define do
  factory :game do
    title "Game of Thrones"
    association :players
  end
end
