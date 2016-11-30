Rails.application.routes.draw do
  namespace :api, path: '/', defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

    end
  end

  post 'signup', to: 'users#create'
end
