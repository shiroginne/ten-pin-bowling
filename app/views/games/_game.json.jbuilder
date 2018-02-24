json.extract! game, :id, :title
json.object game.class.name.underscore
json.url game_url(game, format: :json)
json.players game.players, partial: 'players/player', as: :player
