Rails.application.routes.draw do
  resources :games, only: [:show, :create, :update] do
    resources :turns, only: [:create], controller: "games/turns"
    resources :frame, only: [:show], controller: "games/turns"
  end
end
