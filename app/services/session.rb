class Session

  def self.authenticate(email, password)
    return false if email.blank? || password.blank?

    user = User.find_by(email: email)
    return user if user && user.authenticate(password)

    return false
  end

end