Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get '/clientes/:account_id/extrato', to: 'accounts#extract'
  post '/clientes/:account_id/transacoes', to: 'transactions#create'
end
