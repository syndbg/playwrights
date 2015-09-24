Rails.application.routes.draw do
  root to: 'playwrights#index'

  namespace :api, defaults: { format: :json } do
    resources :playwrights, only: [:index, :show, :update] do
      get 'versions', on: :member
    end
  end
end
