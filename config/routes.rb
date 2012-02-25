Rails.application.routes.draw do

  scope :module => "etabliocms_actualities" do
    namespace :admin do
      resources :categories do
        member do
          put :move
        end
      end
    end
  end

end
