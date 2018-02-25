class Games::MakeTurnsController < ApplicationController
  before_action :load_game, :load_frame, :load_player

  def create
    build_turn
    if @turn_maker.save
      render "games/frames/show", status: :created, location: game_frame_url(@game, @frame)
    else
      render json: @turn.errors, status: :unprocessable_entity
    end
  end

  private
    def load_game
      @game = Game.find(params[:game_id])
    end

    def load_frame
      @frame = @game.frames.find(params[:frame_id])
    end

    def load_player
      @player = @game.players.find(params[:player_id])
    end

    def build_turn
      @turn_maker = TurnMaker.new(@frame, pins_count: params[:pins_count])
    end

    def turn_params
      params.fetch(:turn).permit(:player_id, :pins_count)
    end
end
