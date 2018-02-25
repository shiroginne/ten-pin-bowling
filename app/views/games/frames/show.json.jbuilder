json.partial! "games/frames/frame", frame: @frame
json.url game_frame_url(@frame.game, @frame, format: :json)
json.partial! "players/player", player: @frame.player
json.turns @frame.turns, partial: "games/turns/turn", as: :turn
