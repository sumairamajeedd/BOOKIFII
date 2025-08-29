class DailyRecommendedBooksJob < ApplicationJob
  queue_as :default

  def perform
    User.where.not(current_sign_in_at: nil).find_each do |user|
      UserMailer.welcome_email(user).deliver_later
    end
  end
end
