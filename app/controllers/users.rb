require Padrino.root('app/models/user')
require 'json'

Prive::App.controllers :users do
  post '/update', :with => :id do
    authorize_existing_user!(params[:id])

    User.update(params[:id], params[:user])
    return 200
  end

end
