class Session

  def self.authenticate(email, password)
    return false if email.blank? || password.blank?

    user = User.find_by(email: email)
    if user && user.authenticate(password)
    	UserAvatarWorker.perform_async(user.user_id)
    	return user
    end
    
    return false
  end

end