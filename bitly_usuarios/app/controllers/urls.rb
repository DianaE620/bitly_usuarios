get '/' do
  # La siguiente linea hace render de la vista 
  # que esta en app/views/index.erb
  # Deja a los usuarios ingresar una URL

  @short_url = params[:short_url]

  @urls =  Url.where(user_id: nil)

  erb :index
end

post '/urls' do
  # crea una nueva Url
  long_url = params[:long_url].strip
  @short_url = Url.generate_url
  @url = Url.new(long_url: long_url, short_url: @short_url)
  
  if logged_in?
    @id = session[:id]
    @url = Url.new(long_url: long_url, short_url: @short_url, user_id: @id)
    if @url.save
      @short_url
      redirect to("/profile/#{@id}")
    else
      @urls =  Url.where(user_id: @id)   
      erb :secret
    end
  else
    if @url.save
      @short_url
      redirect to("/")
    else
      @urls =  Url.all    
      erb :index
      # redirect to("/?" + "error=1")
    end
  end

end

get '/:short_url' do

  short_url = params[:short_url]
  url =  Url.find_by(short_url: short_url)
  visitas = url.visits + 1
  url.update(visits: visitas)
  redirect to(url.long_url)

end