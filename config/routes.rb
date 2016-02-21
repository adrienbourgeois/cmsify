Cmsify::Engine.routes.draw do
  resources :text, only: [:show, :update]
end
