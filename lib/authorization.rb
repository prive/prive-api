module Authorization
  def authorize(encrypted_tor_id)
    @user_exists = Sequel::Model.db[:users].where(:encrypted_tor_id => encrypted_tor_id).count > 0 ? true : false
    @current_user = Sequel::Model.db[:users].where(:encrypted_tor_id => encrypted_tor_id, :api_key => params[:api_key]).first # TODO: prevent Replay
  end

  def authorize_new_user!(encrypted_tor_id)
    authorize(encrypted_tor_id)

    if user_exists?
      raise NotAuthorized, "Expected new user, but provided ID=#{encrypted_tor_id} already exists in database."
    end
  end

  def authorize_existing_user!(encrypted_tor_id)
    authorize(encrypted_tor_id)

    unless user_exists? && current_user && encrypted_tor_id == current_user[:encrypted_tor_id]
      raise NotAuthorized
    end
  end

  def user_exists?
    @user_exists
  end

  def current_user
    @current_user
  end

  def not_authorized
    [403,"Not authorized"]
  end
end