json.partial! "games/frames/frame", frame: @frame
json.partial! "players/player", player: @frame.player
json.turns @frame.turns, partial: "games/turns/turn", as: :turn

if @frame.closed?
  json.next do
    json.partial! "games/frames/frame", frame: @game.next_frame
  end
end
