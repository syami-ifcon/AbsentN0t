Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]
  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  root 'home#index'

# User sign in for teacher and admin
  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"


# Admin
  get '/admin' => 'admin#admin_panel'
  post '/add_student' => 'admin#add_student'
  post '/add_teacher' => 'admin#add_teacher'
  post '/add_subject' => 'admin#add_subject'
  get '/dashboard' => 'admin#dashboard'
  post '/date' => 'admin#reported'
  get '/shit' => 'admin#admin'

# Teacher
  resources :lectures, only: [:index,:new,:show] do
    get "/qr" => "lectures#qr_code"
    get '/student_list' => 'lectures#student_list'
    get '/sign_up' => "students#sign_up"
  end
  
# Student
  get "/auth/:provider/callback" => "students#create_from_omniauth"
 

end
