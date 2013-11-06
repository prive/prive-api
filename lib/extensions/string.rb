require 'digest/md5'

class String
  def md5
    Digest::MD5.hexdigest(self)
  end

  def safe_string?
    self.match(/^[0-9A-Za-z\-_]*$/) ? true : false
  end
end