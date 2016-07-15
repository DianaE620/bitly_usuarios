before "/profile/:id" do
  unless session[:id]
    redirect to("/")
  end
end

get '/login' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
 @error = params[:error]
  erb :login
end

post '/login' do
  @usuario = params[:user]
  pass = params[:pass]
  @user = User.find_by(user: @usuario, password: pass)

  if @user
    @id = @user.id
    session[:id] = @id
    redirect to("/profile/#{@id}" )
  else
    redirect to("/login?error=1")
  end
  
end


get '/destruir' do
  session.clear
  redirect to("/")
end