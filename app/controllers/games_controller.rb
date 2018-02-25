class GamesController < ApplicationController
  before_action :load_game, only: [:show, :update]

  def show
  end

  def create
    @game = Game.new(game_params)
    if @game.save
      render :show, status: :created, location: @game
    else
      render_json_error(@game.errors)
    end
  end

  def update
    if @game.update(game_params)
      render :show, status: :ok, location: @game
    else
      render_json_error(@game.errors)
    end
  end

  private
    def load_game
      @game = Game.find(params[:id])
    end

    def game_params
      params.fetch(:game).permit(:title, players_attributes: [:name])
    end
end
