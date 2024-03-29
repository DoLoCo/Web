module AuthToken
  def AuthToken.issue_token(payload)
    payload[:created_at] = Time.now.utc.to_i
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def AuthToken.valid?(token)
    begin
      JWT.decode(token, Rails.application.secrets.secret_key_base)
    rescue
      false
    end
  end
end