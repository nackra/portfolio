Rails.application.routes.draw do
  devise_for :users
  get 'search' => 'searches#search'
  root 'homes#top'

  resources :posts do
    resource :favorites, only: [:create, :destroy]
    resources :post_comments, only: [:create, :edit, :update, :destroy]
  end

  resources :users, only: [:show, :edit, :update, :destroy] do
    get 'favorites' => 'users#favorites'
    collection do
      get 'confirm' => 'users#confirm'
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
