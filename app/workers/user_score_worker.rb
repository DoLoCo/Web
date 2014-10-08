class UserAvatarWorker
  include Sidekiq::Worker

  def perform(user_id)
	user = User.find(user_id);
	# todo grab donations
	# todo calculate total given vs total taken
  end
end