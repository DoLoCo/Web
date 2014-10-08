require 'digest/md5'

class UserAvatarWorker
  include Sidekiq::Worker

  def perform(user_id)
  	user = User.find(user_id);
  	gravatar_prefix = "http://www.gravatar.com/avatar/";
  	# https://en.gravatar.com/site/implement/images/
  	email_hash = Digest::MD5.hexdigest(user.email.gsub(/\s+/, "").downcase);
  	gravatar_url = gravatar_prefix + email_hash;
  	user.update(image_url: gravatar_url);
  end
end