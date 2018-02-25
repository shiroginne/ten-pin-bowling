json.extract! frame, :id, :game_id, :player_id, :state, :score
json.object frame.class.name.underscore
json.url game_frame_url(frame.game, frame, format: :json)
