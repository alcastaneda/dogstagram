get '/photos' do
	@photos = Photo.all

	erb :"photos/index"
end

get '/photos/new' do
	if session[:user_id]	
		erb :"photos/new"
	else
		redirect '/sessions/new'
	end
end

get '/photos/:id' do
	@photo = Photo.find(params[:id])

	erb :"photos/show"
end

post '/photos' do
	# params[photo] takes in all form photo params
	@photo = Photo.new(params[:photo])
	Photo.upload(params[:photo]["photo_url"])
	@photo.user_id = session[:user_id]
	@photo.save

	redirect "/photos/#{@photo.id}"
end

get '/photos/:id/edit' do
	@photo = Photo.find(params[:id])
	
	if session[:user_id] && session[:user_id]==@photo.user_id
		
		erb :"photos/edit"
	else
		redirect '/sessions/new'
	end
end

patch '/photos/:id' do
	@photo = Photo.find(params[:id])
	@photo.update(params[:photo])

	redirect "/photos/#{@photo.id}"
end

delete '/photos/:id' do
	@photo = Photo.find(params[:id])
	if session[:user_id] && session[:user_id] == @photo.user_id
		@photo.destroy()
		redirect '/photos'
	else
		redirect '/sessions/new'
	end
end

get '/user/:id/photos' do
	if session[:user_id] && params[:id].to_i== session[:user_id]
		p session
		@user =User.find(session[:user_id])
		@photos = @user.photos
		erb :"photos/user_photos"
	else
		redirect '/sessions/new'
	end
end







