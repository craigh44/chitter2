require "data_mapper"
env = ENV["RACK_ENV"] || "development"

require 'sinatra'
require 'rack-flash'

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}_2")

require_relative 'peeps'
require_relative 'user'

DataMapper.finalize
DataMapper.auto_upgrade!

set :views, Proc.new { File.join(root, '..', "views") }
enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do 
	@peeps = Peep.all
	erb :index
end

post '/peeps' do
	content = params["content"]
	Peep.create(:content => content, user_id: current_user.id)
	redirect to ('/')
end

get '/users/new' do 
	@peeps = Peep.all
	@user = User.new
	erb :users
end

post '/users/new' do
	@peeps = Peep.all
  @user = User.new(:user_name => params['user_name'],
  								 :email => params['email'], 
  								 :password => params['password'],
  								 :password_confirmation => params['password_confirmation'])
  if @user.save
  	session[:user_id] = @user.id
  	redirect to ('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :users
	end
end

	get '/sessions/new' do 
		erb :sign_in
	end

	post '/sessions/new' do 
		user = User.authenticate(params[:email], params[:password])
		if user
			session[:user_id] = user.id
			redirect to ('/')
		else
			flash[:errors] = ["The email or password is incorrect"]
  	  erb :sign_in
  	end
	end

	delete '/sessions/new' do
  flash[:notice] = "Good bye!"
  session[:user_id] = nil
  redirect to('/')
end


helpers do

  def current_user
    @current_user ||=User.get(session[:user_id]) if session[:user_id]
  end

     include Rack::Utils
     alias_method :h, :escape_html

end


