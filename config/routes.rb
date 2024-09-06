Rails.application.routes.draw do
  get 'products_return_lines/create'
  get 'products_return_lines/update'
  get 'products_return_lines/delete'

  devise_for :users, controllers: { 
    registrations: 'users/registrations' 
  }

  resources :workers do
    resource :worker_bio, only: [:new, :create, :edit, :update]
  end

  resources :bios 

  resources :suppliers do
    resources :products, only: [:new]
    resources :buys, only: [:index, :create]
  end

  resources :products do
    member do
      patch :toggle_state
    end
    resources :inventory_movements, only: [:new, :create, :show] do
      collection do
        get :consulta  # Para manejar la consulta de movimientos de un producto específico
      end
    end
  end

  resources :inventory_movements, only: [:index]
  
  resources :buys do
    member do
      post :place_order
      patch :change_state
    end
    resources :buy_lines, only: [:create, :update, :destroy]
  end

  resources :receptions, only: [:index, :show] do
    member do
      patch :complete  # Acción para completar la recepción
    end
    resources :reception_lines, only: [:update, :destroy] do
      collection do
        post :create  # Acción para crear nuevas líneas de recepción
      end
    end
  end

  resources :reception_lines do
      resources :partial_deliveries, only: [:create, :destroy]
  end

  resources :partial_deliveries, only: [:create, :destroy]

  resources :customers

  resources :sells do
    get 'search_products', to: 'sells#search_products'
    member do
      patch :confirm
    end
    resources :sell_lines, only: [:create, :destroy] do
    end
  end

  resources :products_returns do
    resources :products_return_lines, only: [:create]
    member do
      post :confirm_return
    end
  end

  resources :products_return_lines, only: [:update, :destroy]

  root 'pages#home'
end
