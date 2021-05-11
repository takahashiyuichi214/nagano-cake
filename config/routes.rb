Rails.application.routes.draw do

  devise_for :customers, controllers: {
      sessions:      'customers/sessions',
      passwords:     'customers/passwords',
      registrations: 'customers/registrations'
  }
  devise_for :admins, controllers: {
      sessions:      'admins/sessions',
      passwords:     'admins/passwords',
  }



    root  'public/homes#top'
    get '/' => 'public/homes#top'
    get '/about' => 'public/homes#about'

  scope module: :public do
    post 'customers/my_page' => 'customers#show'
    get 'customers/my_page' => 'customers#show', as: :customer

    get 'customers/unsubscribe' => 'customers#unsubscribe'
    patch 'customers/withdraw' => 'customers#withdraw'
    resources :customers, only: [:edit, :update]


    resources :items, only: [:index, :show]

    delete 'cart_items/destroy_all' => 'cart_items#destroy_all'
    resources :cart_items, only: [:create, :index, :update, :destroy]


    post 'orders/confirm' => 'orders#confirm'
    get 'orders/complete' => 'orders#complete'
    resources :orders, only: [:new, :create, :index, :show]



    resources :addresses, only: [:index, :create, :edit, :update, :destroy]
  end


    get '/admin' => 'admin/homes#top'
    namespace :admin do
      resources :items, only: [:new, :index, :create, :edit, :show, :update]
      resources :genres, only: [:index,:create,:edit,:update]
      resources :customers, only: [:index,:show,:edit,:update]
      get "customers/:id/list" => "customers#list", as: "list"
      resources :orders, only: [:index,:show,:update]
      resources :order_items, only: [:update]
  end
end