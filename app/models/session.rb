# == Schema Information
#
# Table name: sessions
#
#  id         :integer          not null, primary key
#  token      :string           not null
#  ip_address :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Session < ActiveRecord::Base
  belongs_to :user, inverse_of: :sessions
  validates_presence_of :token, :ip_address, :user

  TOKEN_EXPIRE_TIME = 30.days

  def token_valid?
    created_at > TOKEN_EXPIRE_TIME.ago
  end
end
