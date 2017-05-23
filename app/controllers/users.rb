# USERS
# Sign up page

get '/users/new' do
	erb :'users/sign_up'
end

# Create new user && new session
post '/users' do
	@user = User.create(username: params[:username], first_name: params[:first_name], last_name: params[:last_name], password: params[:password])
	if @user
		session[:user_id] = @user.id
		redirect "/user/#{session[:user_id]}/photos"
	else
		@error = "Sign up failed, please try again"
		erb :'users/sign_up'
	end
end
# SESSIONS
# Login page
get '/sessions/new' do
	erb :'users/sign_in'
end
# Authenticate user && set a new session
post '/sessions' do
	@user = User.find_by(username: params[:username])

	if @user && User.authenticate(params[:username], params[:password])
		session[:user_id]= @user.id

		redirect "/user/#{session[:user_id]}/photos"
	else
		@error = "Login failed, please try again"
		erb :'users/sign_in'
	end
end
# Log out && clear session
delete '/sessions/:id'do
	if session[:user_id] == params[:id].to_i
		session.clear
		redirect '/sessions/new'
	else
		redirect '/photos'
	end
end



