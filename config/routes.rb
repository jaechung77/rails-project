Rails.application.routes.draw do
  resources :teachers
  resources :teachings
  resources :timetables
  resources :subjects
  resources :enrolments
  resources :students do
    resources :enrolments
  end
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth'}
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'statics#home', as: 'home'
  get 'contact', to: 'statics#contact_us', as: 'contact'
  get 'login', to: 'statics#log_in', as: 'login'
end
