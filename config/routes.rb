require 'sidekiq/web'

Rails.application.routes.draw do
  post 'callback', to: 'top#callback'
  root to: 'top#index'
end
