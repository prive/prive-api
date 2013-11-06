require Padrino.root('app/models/device')
require 'json'

Prive::App.controllers :devices do
  post '/link' do
    authorize_existing_user!(params[:device][:encrypted_tor_id])

    begin
      Device.create({
        :encrypted_tor_id => params[:device][:encrypted_tor_id],
        :encrypted_device_id => params[:device][:encrypted_device_id]  
      })
    rescue Sequel::UniqueConstraintViolation => e
      return [405, "Device already present"]
    end
  end

  post '/create' do
    authorize_new_user!(params[:device][:encrypted_tor_id])

    api_key = User.create({
      :encrypted_tor_id => params[:device][:encrypted_tor_id]  
    })

    Device.create({
      :encrypted_tor_id => params[:device][:encrypted_tor_id],
      :encrypted_device_id => params[:device][:encrypted_device_id]
    })

    return [ 200, { :api_key => api_key }.to_json ]
  end
end