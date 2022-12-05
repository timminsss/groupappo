Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :gruppettos do
    resources :participations, only: %i[create update destroy]
    resources :chatrooms, only: :show do
      resources :messages, only: :create
    end
  end


  delete "gruppettos/:gruppetto_id/participations/:id", to: "participations#destroy", as: :participant
  get "gruppettos/:gruppetto_id/participations/:id/accept", to: "participations#accept", as: :accept_participation
  get "gruppettos/:gruppetto_id/participations/:id/reject", to: "participations#reject", as: :reject_participation
  get "test", to: "gruppettos#test"

  resources :tracks, only: %i[new create]


  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
