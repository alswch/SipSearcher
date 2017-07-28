Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # == Devise Routes
  devise_for :users, path: 'users', controllers: { sessions: "users/sessions", registrations: "users/registrations" }
  devise_for :admins, path: 'admins', controllers: { sessions: "admins/sessions", registrations: "admins/registrations" }

  # == Custom routes
  root to: "users#home"
  get "/landing" => "users#landing"
  get "/admin_landing" => "admins#admin_landing"
  get "/users" => "users#index"
  get "/bars" => "bars#index"
  get "/admin_reports" => "reports#index"
  get "/neighborhoods" => "neighborhoods#index"
  get "/user_reports/:id" => "users#user_reports"
  get "/admin" => "admins#home"
  get "/admin/users/:id" => "admins#admin_user"
  get "/find_bar" => "bars#find_bar"
  get "/check_user/:id" => "users#check_user"

  # == Google Bars
  get "/local_bars_json" => "bars#local_bars_json"

  # == RESTful Routes
  resources :users do
      resources :reports
  end
  resources :bars
  resources :neighborhoods
  resources :photos
  resources :tags
end
