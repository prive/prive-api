class User
	class << self
		def create
			password = rand(36**32).to_s(36)
			user_id = Sequel::Model.db[:users].insert

			api = OpenfireApi::UserService.new(:url => SensitiveSettings.openfire_url, :secret => SensitiveSettings.openfire_userapi_secret)			
			api.add_user!(:username => user_id, :password => password)

			return { :username => user_id, :password => password }
		rescue OpenfireApi::UserService::UserAlreadyExistsException => e
			puts "User exists. Try again."
			return create
		end
	end
end