require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

require_relative './models/user'
require_relative './models/meal'
require_relative './models/greeting'
require_relative './models/can'
require_relative './models/donation'
require_relative './config/environments'


enable :sessions

before do
  @errors ||= []
  @current_user = User.find_by(:id => session[:user_id])
end

helpers do
  def current_user
    @current_user || nil
  end

  def current_user?
    @current_user == nil ? false : true
  end
end 

get '/' do 
	erb :index
end

get '/signup' do
  erb :signup
end

post '/signup' do
  user = User.new(name: params["name"], phonenumber: params["phonenumber"], email: params["email"], password: params["password"])
  if user.save
    session[:user_id] = user.id
    id = user.id
    redirect('/profile')
  else
    @user = user
    erb :signup
  end
end

get '/login' do
  erb :login
end

post '/login' do
  user = User.find_by(:email => params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id
    redirect('/profile')
  else
    @errors << "Invalid email or password. Try again!"
    erb :login
  end
end

get '/profile' do
  @user_meals = Meal.where(user_id: session[:user_id])
  @user_cans = Can.where(user_id: session[:user_id])
  @user_greetings = Greeting.where(user_id: session[:user_id])
  @user_donations = Donation.where(user_id: session[:user_id])
    if current_user?
      erb :profile
    else
      redirect('/login')
    end
end

get '/meal/create' do
  erb :create_meal
end

post '/meal/create' do
  user = User.find(session[:user_id])
  meal = Meal.create(name: params["name"], will_feed: params["will_feed"], pickup_time: params["pickup_time"], pickup_location: params["pickup_location"], user_id: user.id)
    redirect('/profile/thankyou')
end

get '/meal/update/:meal_id' do
  @meal_to_edit = Meal.find(params["meal_id"])
  erb :update_meal
end 

put '/meal/update/:meal_id' do
  @meal_to_edit = Meal.find(params["meal_id"])
  @meal_to_edit.name = params[:edited_name]
  @meal_to_edit.will_feed = params[:edited_will_feed]
  @meal_to_edit.pickup_time = params[:edited_pickup_time]
  @meal_to_edit.pickup_location = params[:edited_pickup_location]
  @meal_to_edit.save
  redirect('/profile/thankyou')
end

get '/meal/delete/:meal_id' do
  @meal_to_delete = Meal.find(params["meal_id"])
  erb :delete_meal
end

delete '/meal/delete/:meal_id' do
  @meal_to_delete = Meal.find(params["meal_id"])
  @meal_to_delete.delete
  redirect('/profile/thankyou') 
end

# Needs security
get '/cannedfood/create' do
  erb :create_canned
end 

post '/cannedfood/create' do
  user = User.find(session[:user_id])
  can = Can.create(num_cans: params["num_cans"], container: params["container"], pickup_time: params["pickup_time"], pickup_location: params["pickup_location"], user_id: user.id)
  redirect('/profile/thankyou')
end

# Needs security
get '/cannedfood/update/:can_id' do
  @can_to_edit = Can.find(params["can_id"])
  erb :update_canned
end

# Needs security
put '/cannedfood/update/:can_id' do
  @can_to_edit = Can.find(params["can_id"])
  @can_to_edit.num_cans = params[:num_cans]
  @can_to_edit.container = params[:container]
  @can_to_edit.pickup_time = params[:pickup_time]
  @can_to_edit.pickup_location = params[:pickup_location]
  @can_to_edit.save
  redirect('/profile/thankyou')
end

# Needs security
get '/cannedfood/delete/:can_id' do
  @can_to_delete = Can.find(params["can_id"])
  erb :delete_canned
end

delete '/cannedfood/delete/:can_id' do
  @can_to_delete = Can.find(params["can_id"])
  @can_to_delete.delete
  redirect('/profile/thankyou')
end

get '/greeting/create' do
    erb :create_greeting
end 

# Needs security
post '/greeting/create' do
  user = User.find(session[:user_id])
  greeting = Greeting.create(body: params["body"], user_id: user.id)
  redirect('/profile/thankyou')
end 

get 'greeting/update/:greeting_id' do
  @greeting_to_edit = Greeting.find(params["greeting_id"])
  erb :update_greeting
end

put 'greeting/update/:greeting_id' do
  @greeting_to_edit = Greeting.find(params["greeting_id"])
  @greeting_to_edit = params[:body]
  @greeting_to_edit.save
  redirect('/profile/thankyou')
end

get 'greeting/delete/:greeting_id' do
  @greeting_to_delete = Greeting.find(params["greeting_id"])
  erb :delete_greeting
end

delete 'greeting/delete/' do
  @greeting_to_delete = Greeting.find(params["greeting_id"])
  @greeting_to_delete.delete
  redirect('/profile/thankyou')
end

#Misc.
get '/donation/create' do
    erb :create_donation
end 

# Needs security
post '/donation/create' do
  user = User.find(session[:user_id])
  donation = Donation.create(body: params["body"], pickup_time: params["pickup_time"], pickup_location: params["pickup_location"], user_id: user.id)
  redirect('/profile/thankyou')
end 

get 'donation/update/:donation_id' do
  @donation_to_edit = Donation.find(params["donation_id"])
  erb :update_donation
end

put 'donation/update/:donation_id' do
  @donation_to_edit = Donation.find(params["donation_id"])
  @donation_to_edit = params[:body]
  @donation_to_edit.pickup_time = params[:pickup_time]
  @donation_to_edit.pickup_location = params[:pickup_location]
  @donation_to_edit.save
  redirect('/profile/thankyou')
end

get '/profile/thankyou' do
  @user_meals = Meal.where(user_id: session[:user_id])
  @user_cans = Can.where(user_id: session[:user_id])
  @user_greetings = Greeting.where(user_id: session[:user_id])
  @user_donations = Donation.where(user_id: session[:user_id])

  if current_user?
    erb :profty
  else
    redirect('/login')
  end
end

get '/view/donations' do
  @cans = Can.all
  @greetings = Greeting.all
  @meals = Meal.all
  @donations = Donation.all
erb :alldonations
end 

get '/thankyou' do
  if current_user?
    erb :thankyou
  else
    redirect('/login')
  end
end 

get "/logout" do
  session.clear
  redirect('/')
end