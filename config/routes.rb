Rails.application.routes.draw do
  get "home/index"
  get "home/task1_7"
  get "home/task2_4"

  get "login" => "sessions#new"
  post "login" => "sessions#create"
  delete "logout" => "sessions#destroy"

  resources :students, only: [] do
    member do
      get :timetable
    end
  end

  # Ajax で週表示を切り替えるためのエンドポイント
  get 'home/week', to: 'home#week'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :lessons, only: [] do
    member do
      patch :mark_attendance
      patch :mark_absence
      patch :mark_none
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
  post 'home/add_attendance', to: 'home#add_attendance'
end
