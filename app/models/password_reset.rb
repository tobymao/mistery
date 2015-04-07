class PasswordReset < ActiveRecord::Base
  belongs_to :user, inverse_of: :password_resets

  TOKEN_EXPIRE_TIME = 15.minutes

  def token_valid?
    !used && created_at > TOKEN_EXPIRE_TIME.ago
  end
end
