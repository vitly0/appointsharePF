Rails.application.routes.draw do
  namespace :admin do
    get '/search', to: 'searches#search'
    resources :schedules, only: [:index, :show, :edit, :update, :destroy]
    resources :end_users, only: [:index, :show, :edit, :update]
  end

  namespace :public do
    get 'end_user/worked'
  end
  scope module: :public do
    get 'end_users/search', to: 'searches#search'
    devise_scope :end_user do
      post 'end_users/guest_sign_in', to: 'end_users/sessions#guest_sign_in'
    end
    root 'homes#top'
    get 'about' => "homes#about"
    resources :end_users, only: [] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'end_users/users/attends/:id' => 'attends#index', as: 'attend_index'
    get 'end_users/users/:id' => 'end_users#show', as: 'user_page'
    get 'end_users/users' => 'end_users#index', as: 'user_index'
    get 'end_users/users/index/:id' => 'end_users#schedule_index', as: 'user_schedule'
    # end_users/editのようにするとdeviseのルーティングとかぶってしまうためinformationを付け加えている。
    get 'end_users/information/edit/:id' => 'end_users#edit', as: 'edit_information'
    patch 'end_users/information' => 'end_users#update', as: 'update_information'
    patch 'end_users/users' => 'end_users#worked', as: 'update_worked'
    resources :schedules, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
      resources :schedule_comments, only: [:create, :destroy]
      resources :reports, only: [:create, :destroy]
      resource :attends, only: [:index, :create, :destroy]
    end
  end
  devise_for :end_users,skip: [:passwords], controllers: {
    sessions: 'public/sessions',
    registrations: 'public/registrations',
  }
  
  devise_for :admin, skip: [:registrations, :passwords] , controllers: {
    sessions: "admin/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
