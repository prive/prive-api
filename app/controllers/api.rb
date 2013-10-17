require Padrino.root('app/models/user')
require 'json'

Prive::App.controllers :api do
  
  post '/signup' do
    user = User.create

    if user
      return user.to_json
    else
      return [405, "Not allowed"]
    end
  end

  # get :index, :map => '/foo/bar' do
  #   session[:foo] = 'bar'
  #   render 'index'
  # end

  # get :sample, :map => '/sample/url', :provides => [:any, :js] do
  #   case content_type
  #     when :js then ...
  #     else ...
  # end

  # get :foo, :with => :id do
  #   'Maps to url '/foo/#{params[:id]}''
  # end

  # get '/example' do
  #   'Hello world!'
  # end
  

end
