
get "/profile/:id" do
  @id = params[:id]
  @urls =  Url.where(user_id: @id)
  erb :secret
end

get '/users/new' do
  erb :new_user
end

post '/new' do
  nombre = params[:name]
  usuario = params[:user]
  correo = params[:correo]
  pass = params[:pass]
  @user = User.new(name: nombre, user: usuario, email: correo, password: pass)
  
  if @user.save
    erb :login
  else
    @user.errors.full_messages  
    redirect to("/new_user?error=1")
  end
 
end

